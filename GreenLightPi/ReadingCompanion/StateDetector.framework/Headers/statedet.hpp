#ifndef DD_STATE_DETECTOR_HPP
#define DD_STATE_DETECTOR_HPP

#include <string>
#include <vector>
#include <opencv2/opencv.hpp>

#define STATE_MOVING        (0x01u) // 00000001
#define STATE_POINTING      (0x02u) // 00000010
#define STATE_NEWPAGE       (0x04u) // 00000100
#define STATE_STABLE        (0x08u) // 00001000
#define STATE_FLIPPING      (0x10u) // 00010000
#define STATE_TRIGGER       (0x20u) // 00100000
#define STATE_CHANGE        (0x40u) // 01000000
#define STATE_CFLIPPING     (0x80u) // 10000000

#define STATE_TYPE_GRAY     (1)
#define STATE_TYPE_BGR      (1)
#define STATE_TYPE_YUV      (2)


class StateDetector {

public:

    ~StateDetector();
    StateDetector(const cv::Rect &roi, int thresh,
                  int sensitivity, int dsFactor=1,
                  int sensitivityHigh=0);

    std::string getVersion();

    // 重置内部状态.
    void reset();

    // (optional) Set image size.
    void setSize(const cv::Size &size);

    // 检测区域 setter & getter.
    void setRoi(const cv::Rect &roi);
    cv::Rect getRoi();

    // Threshold setter & getter.
    void setThresh(int thresh);
    int getThresh();

    // 灵敏度 setter & getter.
    void setSensitivity(int sensitivity, int sensitivityHigh=0);
    int getSensitivity();

    // Downsample factor getter.
    int getDsFactor();

    // 判断状态.
    int detectState(const cv::Mat &image, int type);
    int detectState(const cv::Mat &image, int type, time_t time);
    int detectStateIn(const cv::Mat &image, int type, time_t timeDiff);

    // For debugging only.
    int reserved(const std::vector<float> &values);

private:

    class StateDetectorImpl;
    StateDetectorImpl *impl;

};


#endif // DD_STATE_DETECTOR_HPP.


