#include "meditationmodel.h"
#include <QDateTime>
#include <QDebug>

namespace
{
QString formatTime(uint seconds) {
    int s = seconds % 60;
    int m = (seconds / 60) % 60;
    int h = (seconds / 60 / 60);

    QString res;
    if (h > 0) {
        res = QString("%1:%2:%3")
                  .arg(h, 2, 10, QChar('0'))
                  .arg(m, 2, 10, QChar('0'))
                  .arg(s, 2, 10, QChar('0'));
    } else {
        res = QString("%1:%2").arg(m, 2, 10, QChar('0')).arg(s, 2, 10, QChar('0'));
    }
    return res;
}
} // anonymous namespace

MeditationModel::MeditationState
MeditationModel::toModelMeditationState(const med::MeditationState state) {
    switch (state) {
        case med::MeditationState::STARTED: return MeditationModel::MeditationState::Started;
        case med::MeditationState::PAUSED: return MeditationModel::MeditationState::Paused;
        case med::MeditationState::STOPPED: return MeditationModel::MeditationState::Stopped;
        case med::MeditationState::IDLE: return MeditationModel::MeditationState::Idle;
    }
    return MeditationModel::MeditationState::Idle;
}

MeditationModel::MeditationModel(QObject* parent) : QObject(parent) {}

MeditationModel::MeditationState MeditationModel::getState() const {
    return state_;
}

uint16_t MeditationModel::getDuration() const {
    return config_.duration_s;
}

uint MeditationModel::getTimeLeft() const {
    return time_left_s_;
}

void MeditationModel::setDuration(uint16_t duration) {
    if (config_.duration_s == duration) {
        qDebug() << "MeditationModel::setDuration-> no change, returning";
        return;
    }
    qDebug() << "MeditationModel::setDuration-> change from "
             << static_cast<int>(config_.duration_s) << " to " << static_cast<int>(duration);

    config_.duration_s = duration;
    emit durationChanged(duration);
    emit configChanged(config_);
}

void MeditationModel::setState(med::MeditationState state) {
    const auto model_state = toModelMeditationState(state);
    if (state_ == model_state) {
        qDebug() << "MeditationModel::stateChanged-> no change, returning";
    }

    qDebug() << "MeditationModel::setDuration-> change from " << static_cast<int>(state_) << " to "
             << static_cast<int>(model_state);

    state_ = model_state;
    emit modelStateChanged(state_);
}

void MeditationModel::setTimeLeft(uint16_t time_left_s) {
    if (time_left_s_ == time_left_s) {
        qDebug() << "MeditationModel::setTimeLeft-> no change, returning";
    }

    qDebug() << "MeditationModel::setTimeLeft-> change from " << time_left_s_ << " to "
             << time_left_s;

    time_left_s_ = time_left_s;

    emit timeLeftChanged(formatTime(time_left_s_));
}

void MeditationModel::startMeditation() {
    emit meditationStarted();
}

void MeditationModel::pauseMeditation() {
    emit meditationPaused();
}

void MeditationModel::stopMeditation() {
    emit meditationStopped();
}
