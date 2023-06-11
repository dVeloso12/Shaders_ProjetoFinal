Shader "Custom/NewSurfaceShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "defaulttexture" {}
        _slider ("bruh", Range (0, 100)) = 0
         _position_boat ("boat_position", Vector) = (1,1,1)
    }

    SubShader
    {
     Cull Off ZWrite Off ZTest Always
        CGPROGRAM
            #pragma surface surf Lambert alpha


        struct Input {
        float2 uv_MainTex;
        float3 worldPos;
        };

         sampler2D _MainTex;
        float3 _position_boat;
        float _slider;
      

        void surf(Input IN, inout SurfaceOutput o) {
              
             fixed3 albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;	
		    	o.Albedo = albedo;
             float render=distance(IN.worldPos.xyz,_position_boat.xyz);
             render*=_slider;
             render=saturate(render);
              o.Alpha =render;
        }

        ENDCG
    }
        FallBack "Diffuse"
}
