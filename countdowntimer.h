#ifndef COUNTDOWNTIMER_H
#define COUNTDOWNTIMER_H

#include <QObject>
#include <QTime>
#include <QTimer>
#include <QSound>
#include <QtDebug>
#include <QSettings>

class CountDownTimer : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QTime remainingTime READ remainingTime WRITE setRemainingTime NOTIFY remainingTimeChanged)
    Q_PROPERTY(QTime pomodoroTime READ pomodoroTime WRITE setPomodoroTime NOTIFY pomodoroTimeChanged)
    Q_PROPERTY(QTime shortBreakTime READ shortBreakTime WRITE setShortBreakTime NOTIFY shortBreakTimeChanged)
    Q_PROPERTY(QTime longBreakTime READ longBreakTime WRITE setLongBreakTime NOTIFY longBreakTimeChanged)

    Q_PROPERTY(int longBreakInterval READ longBreakInterval WRITE setLongBreakInterval NOTIFY longBreakIntervalChanged)
    Q_PROPERTY(bool countDownActive READ countDownActive WRITE setCountDownActive NOTIFY countDownActiveChanged)
    Q_PROPERTY(int currentAction READ currentAction WRITE setCurrentAction NOTIFY currentActionChanged)
    Q_PROPERTY(QString currentActionStr READ currentActionStr WRITE setCurrentActionStr NOTIFY currentActionStrChanged)

public:
    explicit CountDownTimer(QObject *parent = nullptr);

    void handleCountdown();
    void handleTimeout();
    void startTicking();
    void stopTicking();
    void evaluateActionToTimer();

    Q_INVOKABLE void soundAlarm();
    Q_INVOKABLE void readSettings();
    Q_INVOKABLE void writeSettings();

    const QTime &remainingTime() const;
    void setRemainingTime(const QTime &newRemainingTime);

    const QTime &pomodoroTime() const;
    void setPomodoroTime(const QTime &newPomodoroTime);
    Q_INVOKABLE void setPomodoroTime(const int &newPomodoroTimeMinutes);

    const QTime &shortBreakTime() const;
    void setShortBreakTime(const QTime &newShortBreakTime);
    Q_INVOKABLE void setShortBreakTime(const int &newShortBreakTimeMinutes);

    const QTime &longBreakTime() const;
    void setLongBreakTime(const QTime &newLongBreakTime);
    Q_INVOKABLE void setLongBreakTime(const int &newLongBreakTimeMinutes);

    bool countDownActive() const;
    void setCountDownActive(bool newCountDownActive);

    int longBreakInterval() const;
    void setLongBreakInterval(int newLongBreakInterval);

    int currentAction() const;
    void setCurrentAction(int newCurrentAction);
    Q_INVOKABLE void setCurrentAction(QString newCurrentActionString);

    const QString &currentActionStr() const;
    void setCurrentActionStr(const QString &newCurrentActionStr);

signals:
    void remainingTimeChanged();
    void pomodoroTimeChanged();
    void shortBreakTimeChanged();
    void longBreakTimeChanged();
    void countDownActiveChanged();
    void longBreakIntervalChanged();
    void currentActionChanged();
    void timeoutReachedTimeTo(QString wichTimer);

    void currentActionStrChanged();

private:
    QTimer m_timer;
    QTime m_remainingTime;
    QTime m_pomodoroTime;
    QTime m_shortBreakTime;
    QTime m_longBreakTime;
    bool m_countDownActive;

    bool m_timerAlreadyStarted;
    int m_longBreakCounter;
    int m_longBreakInterval;

    int m_currentAction;
    QString m_currentActionStr;
    enum Actions {
        PomodoroAction = Qt::UserRole + 1,
        ShortBreakAction,
        LongBreakAction,
    };

    QSound m_alarm;
    QSettings m_settings;

    const QString POMODORO_ACT_STR = "POMODORO";
    const QString SHORTBREAK_ACT_STR = "SHORT BREAK";
    const QString LONGBREAK_ACT_STR = "LONG BREAK";

    const QString POMODOROTIME_ST_STR = "timer/pomodoroTime";
    const QString SHORTBREAKTIME_ST_STR = "timer/shortBreakTime";
    const QString LONGBREAKTIME_ST_STR = "timer/longBreakTime";
};

#endif // COUNTDOWNTIMER_H
