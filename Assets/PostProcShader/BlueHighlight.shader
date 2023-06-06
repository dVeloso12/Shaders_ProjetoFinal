Shader "Hidden/BlueHiglight"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
         _Color("Color",Color) = (0,0,0,0) 
        [HideInInspector]
        _TurnOn("On",int)= 0

  
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always
        Tags { "RenderType"="Opaque" }
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
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            fixed4 _Color;
            int _TurnOn;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                // just invert the colors
                fixed bluecol= (col.r+col.b+col.g)/3;
                fixed bluecol2=col.b;
                if(_TurnOn!=0){
                col.rgb=0;
                col.g=bluecol/2;
                col.b=bluecol;
              
                }
                //col.rgb = (col.r+col.b+col.g)/3;
                //col.rgb=_Color;

                return col;
            }
            ENDCG
        }
    }
}
