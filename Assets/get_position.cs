using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class get_position : MonoBehaviour
{
    public Material material;
    public BoatController controller;

    private void Start()
    {
        material.SetFloat("_EnableBorderScreen", 0);
    }
    void Update()
    {
        Shader.SetGlobalVector("_position_boat",transform.position);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Obstacle"))
        {
            StartCoroutine(dizy());
        }
    }
    //private void OnTriggerExit(Collider other)
    //{
    //    if (other.CompareTag("Obstacle") )
    //    {
    //        material.SetFloat("_EnableBorderScreen", 0);
    //    }
    //}

    public IEnumerator dizy() 
    {
        material.SetFloat("_EnableBorderScreen", 1);
        yield return new WaitForSeconds(3f);
        material.SetFloat("_EnableBorderScreen", 0);
    }
}
