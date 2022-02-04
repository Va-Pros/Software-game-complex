//
// Created by arti1208 on 31.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_QUESTIONSAVER_H
#define SOFTWARE_GAME_COMPLEX_QUESTIONSAVER_H

#include <QQmlEngine>

class QuestionSaver: public QObject{
    Q_OBJECT

public:
    Q_INVOKABLE void saveTypeInQuestion(const QString& questionText, const QVector<QString>& answers) {
        qDebug() << "Save type in question. Text: " << questionText;
        for (auto& answer : answers) {
            qDebug() << "Answer: " << answer;
        }
    }

    Q_INVOKABLE void saveSingleChoiceQuestion(const QString& questionText, const QVector<QString>& variants, int rightAnswerIndex) {
        qDebug() << "Save single choice question. Text: " << questionText;
        for (int i = 0; i < variants.size(); i++) {
            qDebug() << "Variant: " << variants[i] << " : " << (i == rightAnswerIndex ? "+" : "-");
        }
    }

    Q_INVOKABLE void saveMultipleChoiceQuestion(const QString& questionText, const QVector<QString>& variants, const QVector<int>& rightAnswerIndices) {
        qDebug() << "Save multiple choice question. Text: " << questionText;
        for (int i = 0; i < variants.size(); i++) {
            qDebug() << "Variant: " << variants[i] << " : " << (rightAnswerIndices.contains(i) ? "+" : "-");
        }
    }

    Q_INVOKABLE void saveMatchQuestion(const QString& questionText, const QVector<QString>& leftColumn, const QVector<QString>& rightColumn) {
        qDebug() << "Save match question. Text: " << questionText;

        const QVector<QString>& smaller = leftColumn.size() <= rightColumn.size() ? leftColumn : rightColumn;
        const QVector<QString>& bigger = smaller == leftColumn ? rightColumn : leftColumn;

        for (int i = 0; i < smaller.size(); i++) {
            qDebug() << "Match: " << smaller[i] << " - " << bigger[i];
        }

        for (int i = smaller.size(); i < bigger.size(); ++i) {
            qDebug() << "Not matched: " << bigger[i];
        }
    }

    Q_INVOKABLE void saveTypeInFillQuestion(const QString& questionText, const QVector<int>& offsets, const QVector<QVector<QString>>& answers) {
        QString debugString = questionText;

        int fixer = 0;
        for (int i = 0; i < offsets.size(); ++i) {
            int offset = offsets[i];
            auto listAnswers = answers[i];
            QString gapAnswersString = "[";
            for (int j = 0; j < listAnswers.size(); ++j) {
                gapAnswersString += listAnswers[j] + (j == listAnswers.size() - 1 ? "" : ", ");
            }
            gapAnswersString += "]";
            debugString.insert(offset + fixer, gapAnswersString);
            fixer += gapAnswersString.size();
        }

        qDebug() << "Save type in fill question. Text: " << debugString;
    }

    Q_INVOKABLE void saveDropDownFillQuestion(const QString& questionText, const QVector<int>& offsets, const QVector<QVector<QString>>& answers, const QVector<int>& rightAnswerIndices) {
        QString debugString = questionText;

        int fixer = 0;
        for (int i = 0; i < offsets.size(); ++i) {
            int offset = offsets[i];
            auto listAnswers = answers[i];
            QString gapAnswersString = "[";
            for (int j = 0; j < listAnswers.size(); ++j) {
                gapAnswersString += listAnswers[j] + "(" + (j == rightAnswerIndices[i] ? "+" : "-") + ")" + (j == listAnswers.size() - 1 ? "" : ", ");
            }
            gapAnswersString += "]";
            debugString.insert(offset + fixer, gapAnswersString);
            fixer += gapAnswersString.size();
        }

        qDebug() << "Save type in fill question. Text: " << debugString;
    }

    static QuestionSaver* singletonProvider(QQmlEngine* engine, QJSEngine* scriptEngine)
    {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)

        return new QuestionSaver();
    }
};

#endif //SOFTWARE_GAME_COMPLEX_QUESTIONSAVER_H
