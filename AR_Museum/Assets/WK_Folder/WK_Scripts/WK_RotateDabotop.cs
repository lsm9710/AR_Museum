using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//일정크기로 확대되면 천천히 회전 한다
public class WK_RotateDabotop : MonoBehaviour
{
    //회전 속도
    public float rotAngle= 0.05f;

    // 회전체 회전을 하자
    private void Update()
    {
        RotateObject(rotAngle);
    }
    
    void RotateObject(float rotAngle)
    {
       transform.Rotate( new Vector3(0,0,1), rotAngle);
    }
}
