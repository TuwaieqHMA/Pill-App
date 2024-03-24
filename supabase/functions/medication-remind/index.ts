import { createClient } from 'https://cdn.skypack.dev/@supabase/supabase-js@2';
import { JWT } from 'https://cdn.skypack.dev/google-auth-library@9';


interface Medication {
  id: number;
  medication_name: string;
  time_eat: Date;
  before_after_eating: string;
  number_pill: number;
  user_id: string; // Change to lowercase 'string'
  current_status: string; // Change to lowercase 'string'
  start_date: Date;
  end_date: Date;
}

interface WebhookPayload {
  type: 'INSERT';
  table: string;
  record: Medication;
  schema: 'public';
  old_record: null | Medication;
}

const supabase = createClient(
  Deno.env.get('supabaseUrl')!,
  Deno.env.get('supabaseAnonKey')!
);

console.log("Hello from Functions!");

Deno.serve(async (req) => {
  const payload: WebhookPayload = await req.json();

  const  {body} =  
   supabase
  .from("User")
  .select('fcm_token')
  .eq("id", payload.record.user_id)
  .single() || {};

 
  console.log()
  const fcmToken = body?.fcm_token as string;

  const { default: serviceAccount } = await import('../service-account.json', {
    with: { type: 'json' },
  });

  const accessToken = await getAccessToken({
    clientEmail: serviceAccount.client_email,
    privateKey: serviceAccount.private_key // Change to 'private_key' (lowercase 'key')
  });
  // Type of 'await' operand must either be a valid promise or must not contain a callable 'then' member.deno-ts(1320)
  const res = await fetch(
    `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`, // Change to backticks for string interpolation
    {
      method: 'POST',
      headers: {
        'Content-Type': "application/json",
        Authorization: `Bearer ${accessToken}` // Corrected Bearer token format
      },
      body: JSON.stringify({
        message: {
          token: fcmToken,
          notification: {
            title: 'تذكير دواء',
            body: `${payload.record.time_eat} الساعة  ${payload.record.medication_name}` // Corrected string interpolation
          }
        }
      })
    }
  );

  const resData = await res.json();

  if (res.status < 200 || res.status >= 300) { // Corrected status code comparison
    throw resData;
  }

  return new Response(
    JSON.stringify(resData),
    { headers: { "Content-Type": "application/json" } }
  );
});

const getAccessToken = ({
  clientEmail,
  privateKey
}: {
  clientEmail: string;
  privateKey: string;
}): Promise<string> => {
  return new Promise((resolve, reject) => {
    const jwtClient = new JWT({
      email: clientEmail,
      key: privateKey,
      scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
    });
    jwtClient.authorize((err: Error | null, tokens: { access_token: string } | null) => { 
      if (err) {
        reject(err);
        return;
      }
      resolve(tokens!.access_token!); 
    });
  });
};
