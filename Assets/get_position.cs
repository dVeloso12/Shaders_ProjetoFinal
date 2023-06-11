using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class get_position : MonoBehaviour
{
    public Material material;
    public BoatController controller;
    public bool colided;
    public float controlador;
    private void Start()
    {
        material.SetFloat("_EnableBorderScreen", 0);
    }
    void Update()
    {
        Shader.SetGlobalVector("_position_boat",transform.position);
        controlador = material.GetFloat("_Controlador");
        if (colided == true)
        {
            material.SetFloat("_Controlador", 0.1f);
          
        }

        if (colided == false)
        {
            if (controlador > 0)
            {
                controlador -= 0.02f * Time.deltaTime;
            }

           if(controlador < 0) 
            {
                controlador = 0;
            }
            material.SetFloat("_Controlador", controlador);
        }
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
      //  material.SetFloat("_EnableBorderScreen", 1);
        colided = true;
        yield return new WaitForSeconds(2f);
        colided = false;
       // material.SetFloat("_EnableBorderScreen", 0);
    }
}
