Shader "Unlit/DeliverShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Extrude ("Extrude", Range(0,0.055)) = 0
         _dissolveTex("dissolve",2D) = "defalttexture" {}
         _EdgeColour1 ("Edge colour 1", Color) = (1.0, 1.0, 1.0, 1.0)
		_EdgeColour2 ("Edge colour 2", Color) = (1.0, 1.0, 1.0, 1.0)
		_Level ("Dissolution level", Range (0.0, 1.0)) = 0.1
		_Edges ("Edge width", Range (0.0, 1.0)) = 0.1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        //geral pass 
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
                 float3 normal : NORMAL;
            };



            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                 float3 normal : NORMAL;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Extrude;
            sampler2D _dissolveTex;
            float4 _EdgeColour1;
			float4 _EdgeColour2;
			float _Level;
			float _Edges;



            v2f vert (appdata v)
            {
                v2f o;
                v.vertex.xyz += v.normal * _Extrude;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
     
                float cutout = tex2D(_dissolveTex, i.uv).r;
                fixed4 col = tex2D(_MainTex, i.uv);
                
                if (cutout < _Level)
					discard;

				if(cutout < col.a && cutout < _Level + _Edges)
					col =lerp(_EdgeColour1, _EdgeColour2, (cutout-_Level)/_Edges );

                return col;
            }
            ENDCG
        }
    }
}
