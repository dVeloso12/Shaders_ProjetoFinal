using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PostProcessing : MonoBehaviour
{
    // A Material with the Unity shader you want to process the image with
    public Material mat;
    RenderTexture render;
    bool turnOn = false;

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.E))
        {
            turnOn = !turnOn;
            if (turnOn)
            {
                mat.SetInt("_TurnOn", 1);
            }else
                mat.SetInt("_TurnOn", 0);
        }
    }

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        // Read pixels from the source RenderTexture, apply the material, copy the updated results to the destination RenderTexture
        Graphics.Blit(src, dest, mat);
        //Graphics.Blit(render, dest, mat);
    }
}
