using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DeliverShaderController : MonoBehaviour
{
    Material mat;
    public float extrude;
    public float dissolve;
    public float Edges;
    public AnimationClip Open;
    public AnimationClip Close;
    public Animator animator;

    void Start()
    {
        mat = GetComponent<MeshRenderer>().material;
        extrude = mat.GetFloat("_Extrude");
        dissolve = mat.GetFloat("_Level");
        Edges = mat.GetFloat("_Edges");
        animator = GetComponent<Animator>();

    }

    // Update is called once per frame
    void Update()
    {
        mat.SetFloat("_Extrude",extrude);
        mat.SetFloat("_Level", extrude);
        mat.SetFloat("_Edges", Edges);

    }

    public void AnimationPlay(int i)
    {
        if (i == 0)
        {
            animator.SetTrigger("CanOpen");
            Debug.Log("MOOO");
        }
        
    }
}
