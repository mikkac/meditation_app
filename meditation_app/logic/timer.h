#ifndef TIMER_H
#define TIMER_H

//#include "itimer.h"
#include <QTimer>
namespace med
{
class Timer : public QObject /*, public ITimer*/
{
    Q_OBJECT
  public:
    explicit Timer(QObject* parent = nullptr);
    ~Timer() noexcept = default;

    void startCountdown(uint16_t init_seconds);
    void stopCountdown();
    //    virtual void startCountdown(uint16_t init_seconds) override;
    //    virtual void stopCountdown() override;

  signals:
    void updateTime(uint16_t seconds);
  private slots:
    void tick();

  private:
    uint16_t interval_ms_{1000};
    uint16_t time_left_seconds_{};
    QTimer* timer_;
};

} // namespace med

#endif // TIMER_H
