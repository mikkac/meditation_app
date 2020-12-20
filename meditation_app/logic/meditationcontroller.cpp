#include "meditationcontroller.h"
#include <QDebug>

namespace med
{
MeditationController::MeditationController(Timer& timer, MeditationModel& model, QObject* parent)
    : QObject(parent), timer_{timer}, model_{model} {
    setState(MeditationState::IDLE);

    connect(&timer_, &Timer::updateTime, [this](uint16_t new_time) {
        config_.time_left_s = new_time;
        emit timeLeftChanged(config_.time_left_s);
    });

    connect(&model_, &MeditationModel::configChanged, this, &med::MeditationController::setConfig);
    connect(&model_, &MeditationModel::meditationStarted, this,
            &med::MeditationController::startMeditation);
    connect(&model_, &MeditationModel::meditationPaused, this,
            &med::MeditationController::pauseMeditation);
    connect(&model_, &MeditationModel::meditationStopped, this,
            &med::MeditationController::stopMeditation);

    connect(this, &med::MeditationController::stateChanged, &model_, &MeditationModel::setState);
    connect(this, &med::MeditationController::timeLeftChanged, &model_,
            &MeditationModel::setTimeLeft);
}

void MeditationController::setConfig(MeditationConfig config) {
    config_ = std::move(config);
}

void MeditationController::startMeditation() {
    qDebug() << "MeditationController::startMeditation-> started";
    setState(MeditationState::STARTED);
    timer_.startCountdown(config_.time_left_s);
}

void MeditationController::pauseMeditation() {
    qDebug() << "MeditationController::startMeditation-> paused";
    setState(MeditationState::PAUSED);
    timer_.stopCountdown();
}

void MeditationController::stopMeditation() {
    qDebug() << "MeditationController::startMeditation-> stopped";
    setState(MeditationState::STOPPED);
    timer_.stopCountdown();
    config_.time_left_s = config_.duration_s;
}

void MeditationController::setState(MeditationState state) {
    if (state_ == state) {
        qDebug() << "MeditationController::setState-> state didn't change";
        return;
    }

    qDebug() << "MeditationController::setState-> state changed from " << static_cast<int>(state_)
             << " to " << static_cast<int>(state);
    state_ = state;
    emit stateChanged(state_);
}

} // namespace med
