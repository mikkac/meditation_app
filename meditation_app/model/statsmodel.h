#ifndef STATSMODEL_H
#define STATSMODEL_H

#include <QObject>

class StatsModel : public QObject
{
    Q_OBJECT
public:
    explicit StatsModel(QObject *parent = nullptr);

signals:

};

#endif // STATSMODEL_H
