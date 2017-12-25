Shader "Ex/ShaderProperties"
{
	Properties
	{
		_myColor ( "Example Color", Color ) = ( 1, 1, 1, 1 )
		_myRange( "Example Range", Range( 0, 5 ) ) = 1
		_myTex( "Example Texture", 2D ) = "white" {}
		_myCube( "Example Cube", CUBE ) = "" {}
		_myFloat( "Example Float", Float ) = 0.5
		_myVector( "Example Vector", Vector ) = ( 0.5, 1, 1, 1 )
	}

	SubShader
	{
		CGPROGRAM
			// Type shader - function to call - lighting model
			#pragma surface main Lambert 

			/*
			https ://docs.unity3d.com/Manual/SL-SurfaceShaders.html
			The input structure Input generally has any texture coordinates needed by the shader.
				
				Texture coordinates must be named “uv” followed by texture name
				( or start it with “uv2” to use second texture coordinate set ).

				Additional values that can be put into Input structure :

				float3 viewDir
				- contains view direction, for computing Parallax effects, rim lighting etc.
				float4 with COLOR semantic
				- contains interpolated per-vertex color.
				float4 screenPos
				- contains screen space position for reflection or screenspace effects.
				float3 worldPos
				- contains world space position.
				float3 worldRefl
				- contains world reflection vector if surface shader does not write to o.Normal.
				float3 worldNormal
				- contains world normal vector if surface shader does not write to o.Normal.
				float3 worldRefl; INTERNAL_DATA
				- contains world reflection vector if surface shader writes to o.Normal.
				float3 worldNormal; INTERNAL_DATA
				- contains world normal vector if surface shader writes to o.Normal.
			*/
			struct Input
			{
				float2 uv_myTex;
				float3 worldRefl;
			};

			// In order to use property must be declared inside CGPROGRAM
			fixed4      _myColor; 
			half        _myRange;
			sampler2D   _myTex;
			samplerCUBE _myCube;
			float       _myFloat;
			float4      _myVector;

			/*
			Struct SurfaceOutput
			{
				fixed3 Albedo;   // diffuse color
				fixed3 Normal;   // tanget space normal, if written
				fixed3 Emission;
				half   Specular; // specular power in  0..1 range
				fixed  Gloss;    // specular itensity
				fixed  Alpha;    // alpha for transparency
			}
			*/
			void main( Input IN, inout SurfaceOutput o )
			{
				/*
				ret tex2D( s, t ) : Samples a 2D texture.
					Parameters
					s : [in] The sampler state.
					t : [in] The texture coordinate.
				*/
				o.Albedo = ( tex2D( _myTex, IN.uv_myTex ) * _myRange ).rgb;

				o.Emission = texCUBE( _myCube, IN.worldRefl ).rgb;
			}

		ENDCG
	}

	Fallback "Diffuse"
}