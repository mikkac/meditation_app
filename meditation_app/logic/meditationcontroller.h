#ifndef MEDITATIONCONTROLLER_H
#define MEDITATIONCONTROLLER_H

#include "meditationconfig.h"
#include "meditationstate.h"
#include "model/meditationmodel.h"
#include "timer.h"
#include <QObject>

namespace med
{
class MeditationController : public QObject
{
    Q_OBJECT
  public:
    explicit MeditationController(Timer& timer, MeditationModel& model, QObject* parent = nullptr);

  signals:
    void stateChanged(MeditationState state);
    void timeLeftChanged(uint16_t time_left);

  public slots:
    void setConfig(MeditationConfig config);
    void startMeditation();
    void pauseMeditation();
    void stopMeditation();

  private:
    void setState(MeditationState state);

  private:
    Timer& timer_;
    MeditationModel& model_;
    MeditationConfig config_;
    MeditationState state_;
};

} // namespace med
#endif // MEDITATIONCONTROLLER_H
