using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;

//카메라에서 레이를 발사해서 부딪히는 곳에 조준점이 보이게 하고 싶다.
public class SM_ARManager : MonoBehaviour
{
    public static SM_ARManager instance;
    //ARRaycastManager
    ARRaycastManager arRayManager;
    //화면 중앙
    Vector3 viewCenter;
    LineRenderer line;

    GameObject cam;
    Transform mainTr;
    PuzzleFramePiece pfp;

    #region (라인렌더 레이져 효과 내기) == 왕규
    //line offset 속도 값 
    float offsetSpeed = 2.5f;
    //변하는 옵셋값 담기
    float xOffset = 1f;
    #endregion

    //후광이 온,오프 뙜는지 판단
    bool glowAction = false;

    //sm_ar메니져 싱글톤 만들기
    void Awake()
    {
        instance = this;
    }

    // Start is called before the first frame update
    void Start()
    {
        arRayManager = GetComponent<ARRaycastManager>();
        viewCenter.x = Screen.width * 0.5f;
        viewCenter.y = Screen.height * 0.5f;
        viewCenter.z = 0;

        cam = transform.Find("AR Camera").gameObject;

        mainTr = cam.transform;
        line = cam.GetComponent<LineRenderer>();
        line.positionCount = 2;
#if UNITY_EDITOR
        GameObject.Find("AR Camera").GetComponent<CamRotate>().enabled = true;
#endif
    }

    // 레이에 부딪힌 오브젝트 위치값
    Transform clickedPuzzle;
   
    void Update()
    {
#region(라인렌더 레이져 효과 내기) ==왕규
        //레이저 재질의 offset의 값을 계속 감소시키는 값.
        xOffset -= Time.deltaTime * offsetSpeed;

        // line.material.mainTextureOffset = new Vector2(xOffset, 0);
        line.material.SetTextureOffset("_MainTex", new Vector2(xOffset, 0));

#endregion

        //Ray ray = cam.ScreenPointToRay(viewCenter);
        Ray ray = new Ray(mainTr.position, mainTr.forward);

        // Debug.DrawRay(mainTr.position, mainTr.forward*100, Color.red);

        //만약 레이가 어딘가에 부딪히면
        RaycastHit hit;
        int layer = 0;

        line.SetPosition(0, mainTr.position + new Vector3(0, -0.5f, 0));

        if (clickedPuzzle == null && Input.GetMouseButtonDown(0))
        {
            
            layer = 1 << LayerMask.NameToLayer("Puzzle");
            if (Physics.Raycast(ray, out hit, 100, layer))
            {
                clickedPuzzle = hit.transform;

                //후광 보이도록 === 왕규
                clickedPuzzle.GetChild(0).GetComponent<MeshRenderer>().enabled = true;
                //후광 재질이 번쩍이도록 한다
                glowAction = true;
            }
        }
        
        if (clickedPuzzle)
        {
            layer = 1 << LayerMask.NameToLayer("PuzzleFrames");
            if (Physics.Raycast(ray, out hit, 100, layer))
            {
                clickedPuzzle.position = hit.point;
                pfp = hit.transform.GetComponent<PuzzleFramePiece>();
            }
            else
            {
                layer = 1 << LayerMask.NameToLayer("Test");
                if (Physics.Raycast(ray, out hit, 100, layer)) clickedPuzzle.position = hit.point;
            }
            line.SetPosition(1, clickedPuzzle.position);
        }

        if (Input.GetMouseButtonUp(0))
        {
            if (pfp == null || pfp.isEnter == false) OnMouseButtonUp();
        }

        if (glowAction) clickedPuzzle.GetChild(0).GetComponent<MeshRenderer>().material.mainTextureOffset = new Vector2(-xOffset, 0);
    }
    public void OnMouseButtonUp()
    {
        //후광 안보이게 === 왕규
        if (clickedPuzzle != null)
        {
            clickedPuzzle.GetChild(0).GetComponent<MeshRenderer>().enabled = false;
            glowAction = false;
            clickedPuzzle = null;
            pfp = null;
        }
    }
    
}
