using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Floater : MonoBehaviour
{
    public Transform[] Floaters;
    public float UnderWaterDrag = 3f;
    public float UnderWaterAngularDrag = 1f;
    public float AirDrag = 0f;
    public float AirAngularDrag = 0.05f;
    public float FloatingPower = 15f;
    public float WaterHeight = 0f;

    Rigidbody Rb;
    bool Underwater;
    int FloatersUnderWater;

    WaterController wave;
    // Start is called before the first frame update
    void Start()
    {
        wave = GameObject.Find("Ocean").GetComponent<WaterController>();
        Rb = this.GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        FloatersUnderWater = 0;
        Vector3 vel=Rb.velocity;
      
            //float diff = Floaters[i].position.y - wave.getHeightAtPosition(Floaters[i].position);
            float diff = transform.position.y;
            //Debug.Log(transform.position.y+" "+diff);
        if (transform.position.y < 0)
        {
            //Debug.Log(transform.position.y + "OFF");
            //Rb.AddForceAtPosition(Vector3.up * FloatingPower * Mathf.Abs(diff), transform.position, ForceMode.Force);

            vel.y = FloatingPower;
            if (!Underwater)
            {
                Underwater = true;
                SwitchState(true);
            }


            if (Underwater && FloatersUnderWater == 0)
            {
                Underwater = false;
                SwitchState(false);
            }
        }
        else if(transform.position.y>5)
            vel.y = -FloatingPower * 3;

        Rb.velocity = vel;
    }
    void SwitchState(bool isUnderwater)
    {
        if (isUnderwater)
        {
            Rb.drag = UnderWaterDrag;
            Rb.angularDrag = UnderWaterAngularDrag;
        }
        else
        {
            Rb.drag = AirDrag;
            Rb.angularDrag = AirAngularDrag;
        }
    }
}
