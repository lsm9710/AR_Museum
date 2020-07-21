using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestMove : MonoBehaviour
{
    float speed = 5f;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Move(GetInputVector3XZ());
    }

    Vector3 GetInputVector3XZ()
    {
        Vector3 vec = Vector3.zero;
        vec.x = Input.GetAxis("Horizontal");
        vec.z = Input.GetAxis("Vertical");
        return vec;
    }

    void Move(Vector3 dir)
    {
        transform.position += dir.normalized * speed * Time.deltaTime;
    }
}
