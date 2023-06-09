Shader "Unlit/Test"
{
     Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _NoiseTex ("cutout_texture", 2D) = "defaulttexture" {}
        _slider ("bruh", Range (0, 100)) = 0
        _Alpha ("Alpha", Range (0, 1)) = 0
       
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha    
        LOD 200

        Pass
        {
        
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;

            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;

                float3 textCoord : TEXCOORD3;

            };

            sampler2D _MainTex;
            sampler2D _NoiseTex;
            sampler2D _NoiseTex_ST;
            float4 _MainTex_ST;
            float3 _position_boat;
            float  _slider;
            float _Alpha;

            v2f vert (appdata v)
            {
                v2f o;
                 if(v.vertex.x <= _Alpha)
                v.vertex.x = _Alpha - 0.5;
                //o.wpos=mul(unity_ObjectToWorld,v.vertex); 
                o.vertex = UnityObjectToClipPos(v.vertex);

               



                //o.textCoord.xy = v.uv.xy;

                //float dist = distance(_WorldSpaceCameraPos, mul(unity_ObjectToWorld, v.vertex));

                // // map the distance to an fade interval
                //float beginfade = 20;
                //float endfade = 30;
                //float alpha = min(max(dist, beginfade), endfade) - beginfade;
                //alpha = 1 - alpha / (endfade - beginfade);

                //// put alpha somewhere unused to deliver it to the fragment shader
                //o.textCoord.z = alpha ;



                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

              
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
               fixed4 col_2=tex2D(_NoiseTex,i.uv);
               fixed4 col =tex2D(_MainTex,i.uv);

                //col.a = i.textCoord.z;
                //col.a = 0;
                return col;
            }
            ENDCG
        }
    }
}
