Shader "Unlit/detect"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _NoiseTex ("cutout_texture", 2D) = "defaulttexture" {}
        _slider ("bruh", Range (0, 100)) = 0
       
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
        Blend SrcAlpha OneMinusSrcAlpha
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
                float render:TEXCOORD1;
                float3 wpos:TEXCOORD2;
            };

            sampler2D _MainTex;
            sampler2D _NoiseTex;
            sampler2D _NoiseTex_ST;
            float4 _MainTex_ST;
            float3 _position_boat;
            float  _slider;
            v2f vert (appdata v)
            {
                v2f o;
                o.wpos=mul(unity_ObjectToWorld,v.vertex); 
                o.vertex = UnityObjectToClipPos(v.vertex);



                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

              
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
               fixed4 col_2=tex2D(_NoiseTex,i.uv);
               fixed4 col =tex2D(_MainTex,i.uv);
             
                i.render=distance(i.wpos.xyz,_position_boat.xyz);
                i.render/=_slider;
                i.render=saturate(1-i.render);
                col.a=i.render;
                //if(i.render>0 && i.render<0.1)
                //{
                // col.rgb=float4(1,1,0,1);
            
                //}
                return col;
            }
            ENDCG
        }
    }
}
