using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoatController : MonoBehaviour
{
    private Rigidbody rigidbody;

    [SerializeField] private float ForwardForce = 10;
    [SerializeField] private float TurningTorque = 50;

    [SerializeField] private float turningSpeed = 1f;

    [SerializeField] public float maxTurnAngle = 360;

    public float angle { private set; get; }

    // Start is called before the first frame update
    void Start()
    {
        rigidbody = GetComponent<Rigidbody>();
        angle = 0;
    }

    // Update is called once per frame
    void Update()
    {
        //Forward Force
        if (Input.GetKey(KeyCode.W))
        {
            GoForward();
        }
        TurnShip(Input.GetAxis("Horizontal"));
        Shader.SetGlobalVector("_position_boat", transform.position);
    }

    void GoForward()
    {
        rigidbody.AddForce(transform.forward * ForwardForce, ForceMode.Acceleration);

        Vector3 torque = torque = new Vector3(0, TurningTorque , 0);
        rigidbody.AddTorque(torque);
    }

    private void TurnShip(float input)
    {
        if ((angle < -maxTurnAngle && input > 0) || (angle > maxTurnAngle && input < 0) || (angle <= maxTurnAngle && angle >= -maxTurnAngle && input != 0))
        {
            Vector3 turnAmt = Vector3.up * input * turningSpeed * Time.deltaTime;
            angle += turnAmt.x;
            transform.Rotate(turnAmt, Space.Self);
        }
    }
}
