Shader "Custom/LightHouse"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Slider("Slider",Range(0,5))=0
		[PowerSlider(4)] _Exponent ("Exponent", Range(0.25, 4)) = 1

        [Toggle]
        _TurnOn("On",Int)=0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        LOD 200

        CGPROGRAM
        #pragma surface surf NoLight alpha noambient

        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldNormal;
			float3 viewDir;
        };

        fixed4 _Color;
        float _Slider;
        float _Exponent;
        int _TurnOn;
     

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = _Color;
            
            

            o.Albedo = c.rgb;
            o.Alpha = c.a*pow(IN.uv_MainTex.y,_Slider);

            float fresnel = pow(dot(normalize( IN.viewDir),o.Normal),_Exponent);
			o.Alpha*=fresnel;
            if(_TurnOn==0)
            o.Alpha=0;
            
        }

           fixed4 LightingNoLight(SurfaceOutput s, fixed3 lightDir, fixed atten)
     {
         fixed4 c;
         c.rgb = s.Albedo; 
         c.a = s.Alpha;
         return c;
     }
        ENDCG
    }
    FallBack "Diffuse"
}
