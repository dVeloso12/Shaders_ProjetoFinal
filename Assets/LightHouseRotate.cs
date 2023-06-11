using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightHouseRotate : MonoBehaviour
{
    public GameObject Ligh;
    Material Light;
    public Color normal, red, blue;
    public Transform LightOri;
    public int Pickup, Deliver;
    bool turnOn,RightIsland;
    public float RotateSpeed;
    void Start()
    {
        Light = Ligh.GetComponent<Renderer>().material;
        Light.SetColor("_Color", normal);
    }

    // Update is called once per frame
    void Update()
    {

        if (GameManager.Instance.Pickup == Pickup || GameManager.Instance.Deliver == Deliver)
        {
            RightIsland = true;
            Light.SetInt("_TurnOn", 1);
            Debug.Log("FUUU");
        }
        else
        {
            RightIsland = false;
            Light.SetInt("_TurnOn", 0);
        }


        if (Input.GetKeyDown(KeyCode.E))
        {

            turnOn = !GameManager.Instance.FocusVision;

            

        }

        if (turnOn && RightIsland)
        {
            if (GameManager.Instance.Pickup == Pickup)
            {
                Light.SetColor("_Color", red);
            }
            else Light.SetColor("_Color", blue);
        }
        else
            Light.SetColor("_Color", normal);

        LightOri.Rotate(0, RotateSpeed, 0);
    }
}
