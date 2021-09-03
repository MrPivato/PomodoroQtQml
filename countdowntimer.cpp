#include "countdowntimer.h"

CountDownTimer::CountDownTimer(QObject *parent) : QObject(parent),
    m_timer(new QTimer(this)),
    m_remainingTime(QTime(00, 25, 00)),
    m_pomodoroTime(QTime(00, 25, 00)),
    m_shortBreakTime(QTime(00, 05, 00)),
    m_longBreakTime(QTime(00, 10, 00)),
    m_countDownActive(false),
    m_timerAlreadyStarted(false),
    m_longBreakCounter(0),
    m_currentAction(PomodoroAction),
    m_longBreakInterval(4),
    m_alarm(":/Resources/beep.wav"),
    m_settings(new QSettings)
{
    readSettings();

    m_alarm.setLoops(2);

    QObject::connect(&m_timer, &QTimer::timeout, [=](){
        setRemainingTime(m_remainingTime.addSecs(-1));
        handleTimeout();
    });
    m_timer.stop();
}

const QTime &CountDownTimer::remainingTime() const
{
    return m_remainingTime;
}

void CountDownTimer::setRemainingTime(const QTime &newRemainingTime)
{
    if (m_remainingTime == newRemainingTime)
        return;
    m_remainingTime = newRemainingTime;
    emit remainingTimeChanged();
}

void CountDownTimer::evaluateActionToTimer()
{
    switch (m_currentAction) {
    case PomodoroAction:
        setRemainingTime(m_pomodoroTime);
        break;
    case ShortBreakAction:
        setRemainingTime(m_shortBreakTime);
        break;
    case LongBreakAction:
        setRemainingTime(m_longBreakTime);
        break;
    default:
        setRemainingTime(m_pomodoroTime);
        break;
    }
}

void CountDownTimer::handleCountdown()
{
    if (m_countDownActive) {
        if(!m_timerAlreadyStarted) {
            evaluateActionToTimer();
        }

        m_timerAlreadyStarted = true;
        startTicking();

    } else {
        stopTicking();
    }
}

void CountDownTimer::soundAlarm()
{
    m_alarm.play();
}

void CountDownTimer::readSettings()
{
    QStringList keys = m_settings.allKeys();
    if (keys.count() == 3) {
        setPomodoroTime(m_settings.value(POMODOROTIME_ST_STR).toInt());
        setShortBreakTime(m_settings.value(SHORTBREAKTIME_ST_STR).toInt());
        setLongBreakTime(m_settings.value(LONGBREAKTIME_ST_STR).toInt());
    } else {
        writeSettings();
    }
}

void CountDownTimer::writeSettings()
{
    // they are initiated on the constructor
    m_settings.setValue(POMODOROTIME_ST_STR, m_pomodoroTime.minute());
    m_settings.setValue(SHORTBREAKTIME_ST_STR, m_shortBreakTime.minute());
    m_settings.setValue(LONGBREAKTIME_ST_STR, m_longBreakTime.minute());
}

void CountDownTimer::handleTimeout()
{
    if (m_remainingTime == QTime(00, 00, 00)) {
        m_timerAlreadyStarted = false;
        stopTicking();
        soundAlarm();

        // Aparentemente tudo certo com essa lógica
        switch (m_currentAction) {
        case PomodoroAction:
            if (m_longBreakCounter == m_longBreakInterval) {
                m_currentAction = LongBreakAction;
                m_longBreakCounter = 0;
                emit timeoutReachedTimeTo("long break");
            } else {
                m_currentAction = ShortBreakAction;
                m_longBreakCounter++;
                emit timeoutReachedTimeTo("short break");
            }
            break;
        case ShortBreakAction:
            m_currentAction = PomodoroAction;
            emit timeoutReachedTimeTo("pomodoro");
            break;
        case LongBreakAction:
            m_currentAction = PomodoroAction;
            emit timeoutReachedTimeTo("pomodoro");
            break;
        default:
            m_currentAction = PomodoroAction;
            emit timeoutReachedTimeTo("pomodoro");
            break;
        }

        evaluateActionToTimer();
    }
}

void CountDownTimer::startTicking()
{
    m_timer.start(1000);
    m_countDownActive = true;
}

void CountDownTimer::stopTicking()
{
    m_timer.stop();
    setCountDownActive(false);
}

const QTime &CountDownTimer::pomodoroTime() const
{
    return m_pomodoroTime;
}

void CountDownTimer::setPomodoroTime(const QTime &newPomodoroTime)
{
    if (m_pomodoroTime == newPomodoroTime)
        return;
    m_pomodoroTime = newPomodoroTime;
    evaluateActionToTimer();
    emit pomodoroTimeChanged();
}

void CountDownTimer::setPomodoroTime(const int &newPomodoroTimeMinutes)
{
    QTime newPomodoroTime = QTime(00, newPomodoroTimeMinutes, 00);

    if (m_pomodoroTime == newPomodoroTime || m_countDownActive)
        return;
    m_pomodoroTime = newPomodoroTime;
    evaluateActionToTimer();
    emit pomodoroTimeChanged();
}

const QTime &CountDownTimer::shortBreakTime() const
{
    return m_shortBreakTime;
}

void CountDownTimer::setShortBreakTime(const QTime &newShortBreakTime)
{
    if (m_shortBreakTime == newShortBreakTime)
        return;
    m_shortBreakTime = newShortBreakTime;
    emit shortBreakTimeChanged();
}

void CountDownTimer::setShortBreakTime(const int &newShortBreakTimeMinutes)
{
    QTime newShortBreakTime = QTime(00, newShortBreakTimeMinutes, 00);

    if (m_shortBreakTime == newShortBreakTime || m_countDownActive)
        return;
    m_shortBreakTime = newShortBreakTime;
    evaluateActionToTimer();
    emit shortBreakTimeChanged();
}

const QTime &CountDownTimer::longBreakTime() const
{
    return m_longBreakTime;
}

void CountDownTimer::setLongBreakTime(const QTime &newLongBreakTime)
{
    if (m_longBreakTime == newLongBreakTime)
        return;
    m_longBreakTime = newLongBreakTime;
    emit longBreakTimeChanged();
}

void CountDownTimer::setLongBreakTime(const int &newLongBreakTimeMinutes)
{
    QTime newLongBreakTime = QTime(00, newLongBreakTimeMinutes, 00);

    if (m_longBreakTime == newLongBreakTime || m_countDownActive)
        return;
    m_longBreakTime = newLongBreakTime;
    evaluateActionToTimer();
    emit longBreakTimeChanged();
}

bool CountDownTimer::countDownActive() const
{
    return m_countDownActive;
}

void CountDownTimer::setCountDownActive(bool newCountDownActive)
{
    if (m_countDownActive == newCountDownActive)
        return;
    m_countDownActive = newCountDownActive;
    handleCountdown();
    emit countDownActiveChanged();
}

int CountDownTimer::longBreakInterval() const
{
    return m_longBreakInterval;
}

void CountDownTimer::setLongBreakInterval(int newLongBreakInterval)
{
    if (m_longBreakInterval == newLongBreakInterval)
        return;
    m_longBreakInterval = newLongBreakInterval;
    emit longBreakIntervalChanged();
}

int CountDownTimer::currentAction() const
{
    return m_currentAction;
}

void CountDownTimer::setCurrentAction(int newCurrentAction)
{
    if (m_currentAction == newCurrentAction || m_countDownActive)
        return;
    m_currentAction = newCurrentAction;
    m_timerAlreadyStarted = false;
    evaluateActionToTimer();

    emit currentActionChanged();
}

void CountDownTimer::setCurrentAction(QString newCurrentActionString)
{
    int newCurrentAction;
    newCurrentActionString = newCurrentActionString.toUpper();

    if (newCurrentActionString == "POMODORO") {
        newCurrentAction = PomodoroAction;
    } else if(newCurrentActionString == "SHORT-BREAK") {
        newCurrentAction = ShortBreakAction;
    }else if(newCurrentActionString == "LONG-BREAK") {
        newCurrentAction = LongBreakAction;
    } else {
        return;
    }

    if (m_currentAction == newCurrentAction || m_countDownActive)
        return;
    m_currentAction = newCurrentAction;
    m_timerAlreadyStarted = false;
    evaluateActionToTimer();

    emit currentActionChanged();
}
