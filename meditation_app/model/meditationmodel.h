#ifndef MEDITATIONMODEL_H
#define MEDITATIONMODEL_H

#include "logic/meditationconfig.h"
#include "logic/meditationstate.h"
#include <QObject>

class MeditationModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(MeditationState state READ getState NOTIFY modelStateChanged)
    Q_PROPERTY(uint duration READ getDuration WRITE setDuration NOTIFY durationChanged)
    Q_PROPERTY(QString durationFormatted READ getDurationFormatted)

  public:
    enum class MeditationState {
        Started,
        Paused,
        Stopped,
        Idle,
    };
    Q_ENUM(MeditationState);

    static MeditationState toModelMeditationState(const med::MeditationState state);

    explicit MeditationModel(QObject* parent = nullptr);

    MeditationState getState() const;
    uint getDuration() const;
    QString getDurationFormatted() const;
    uint getTimeLeft() const;
    void setDuration(uint duration);

  signals:
    // used by QML
    void modelStateChanged(MeditationState state);
    void durationChanged(uint16_t duration);
    void timeLeftChanged(QString timeLeftFormatted);

    // used by C++
    void configChanged(med::MeditationConfig config);

    void meditationStarted();
    void meditationPaused();
    void meditationStopped();

  public slots:
    // used by C++
    void setState(med::MeditationState state);
    void setTimeLeft(uint16_t time_left_s);

    // used by QML
    void startMeditation();
    void pauseMeditation();
    void stopMeditation();

  private:
    MeditationState state_{};
    med::MeditationConfig config_{};
    uint time_left_s_{};
};

#endif // MEDITATIONMODEL_H
