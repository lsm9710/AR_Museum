using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CamRotate : MonoBehaviour
{
    // - 회전속도
    public float rotSpeed = 200;

    float mx;
    float my;

    // Update is called once per frame
    void Update()
    {
        float h = GetAxisVec2XY().x;
        float v = GetAxisVec2XY().y;

        //회전방향
        RotateOBJ(h, v, ref mx, ref my);

        //고개돌리는 반경에 제약을 두고싶다
        my = Mathf.Clamp(my, -90, 90);

        transform.eulerAngles = new Vector2(-my, mx);
    }

    Vector2 GetAxisVec2XY()
    {
        Vector2 v = new Vector2(0, 0);
        //1. 사용자 입력에 따라
        v.x = Input.GetAxis("Mouse X");
        v.y = Input.GetAxis("Mouse Y");

        return v;
    }

    //기능 : 오브젝트를 회전하는 기능
    //인자 : h = 마우스 x 입력값
    //       v = 마우스 y 입력값
    //      mx 회전 누적값(ref)
    //      my 회전 누적값(ref)
    //리턴 : 없음
    void RotateOBJ(float h, float v, ref float mx, ref float my)
    {
        mx += h * rotSpeed * Time.deltaTime;
        my += v * rotSpeed * Time.deltaTime;
    }
}
