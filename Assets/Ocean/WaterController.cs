using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaterController : MonoBehaviour
{

    [SerializeField] Material oceanMat;
    [SerializeField] WavesData waveData;


    private void Awake()
    {
        waveData = GetDataFromShader();
    }

    private void Update()
    {
        UpdateOceanMatValues();
    }

    public WavesData GetDataFromShader()
    {
        if(oceanMat != null)
        {

            float lenght = oceanMat.GetFloat("_Wavelengh");

            WavesData wave = new WavesData(oceanMat.GetFloat("_Wavelengh"), oceanMat.GetFloat("_Speed"), oceanMat.GetFloat("_Steepness"), oceanMat.GetVector("_Direction"));

            return wave;
        }
        return null;
    }

    public float getHeightAtPosition(Vector3 position)
    {
        float time = Time.timeSinceLevelLoad;
        Vector3 currentPosition = GetWaveAddition(position, time);

        for (int i = 0; i < 3; i++)
        {
            Vector3 diff = new Vector3(position.x - currentPosition.x, 0, position.z - currentPosition.z);
            currentPosition = GetWaveAddition(diff, time);
        }

        return currentPosition.y;
    }

    public Vector3 GetWaveAddition(Vector3 position, float timeSinceStart)
    {
        Vector3 result = new Vector3();

   
            result = GerstnerWave(position, waveData.Direction, waveData.Steepness, waveData.WaveLenght, waveData.Speed, timeSinceStart);
        

        return result;
    }

    public Vector3 GerstnerWave(Vector3 position, Vector2 Direction, float Steepness, float WaveLenght, float Speed , float timeSinceStart)
    {
        float k = (2 * Mathf.PI) / (WaveLenght);
        float c = Mathf.Sqrt(9.8f / k) * Speed;

        Vector2 normalizedDirection = Direction.normalized;


        float dotp = Vector2.Dot(normalizedDirection, new Vector2(position.x,position.z));

        float f = k * (dotp - (Speed * timeSinceStart));

        float a = Steepness / k;
;

        return new Vector3(normalizedDirection.x * a * Mathf.Cos(f),50* a * Mathf.Sin(f), normalizedDirection.y * a * Mathf.Cos(f));
    }


    void UpdateOceanMatValues()
    {
        if(oceanMat != null)
        {
            oceanMat.SetFloat("_Steepness",waveData.Steepness);
            oceanMat.SetFloat("_Wavelengh", waveData.WaveLenght);
            oceanMat.SetFloat("_Speed", waveData.Speed);
            oceanMat.SetVector("_Direction", waveData.Direction);

        }
    }
}

[System.Serializable]
public class WavesData
{
    [Header("Waves Data")]
    public float WaveLenght = 0.29f;
    public float Speed = 0.19f;
    [Range(0f, 1f)] public float Steepness = 0.495f;
    public Vector2 Direction = new Vector2(1, 1);

    public WavesData(float waveLenght, float speed, float steepness, Vector2 direction)
    {
        WaveLenght = waveLenght;
        Speed = speed;
        Steepness = steepness;
        Direction = direction;
    }
}
