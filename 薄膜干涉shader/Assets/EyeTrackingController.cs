using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using PXR.EyeTracking;

public class EyeTrackingController : MonoBehaviour
{
    private Vector3 gazePoint;

    void Start()
    {
        // 初始化眼动追踪
        PXR_EyeTracker.Init();
    }

    void Update()
    {
        // 更新眼动追踪数据
        PXR_EyeTracker.Update();
        
        // 获取注视点位置
        if (PXR_EyeTracker.TryGetEyeGazePoint(out gazePoint))
        {
            // 更新摄像机位置为注视点位置
            transform.position = gazePoint;
        }
    }
}