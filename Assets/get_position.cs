using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class get_position : MonoBehaviour
{
    void Start()
    {
        
    }

   
    void Update()
    {
        Shader.SetGlobalVector("_position_boat",transform.position);
    }
}
