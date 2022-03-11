//
// Created by arti1208 on 31.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_QUESTIONSAVER_H
#define SOFTWARE_GAME_COMPLEX_QUESTIONSAVER_H

#include <QQmlEngine>
#include <QTimer>
#include <QVariantList>
#include "QuestionDifficulty.h"

class QuestionSaver : public QObject {
Q_OBJECT


public:
    Q_INVOKABLE void saveTypeInQuestion(
            const QString &theme,
            const int difficulty,
            const bool isActive,
            const QString &questionText,
            const QVector<QString> &answers
    ) {
        qDebug() << "Save type in question. Text: " << questionText;
        qDebug() << "Theme: '" << theme << "'; difficulty: " << difficulty << "; isActive: " << isActive;
        for (auto &answer: answers) {
            qDebug() << "Answer: " << answer;
        }
        QVariantList data;
        data.append(theme);
        data.append(difficulty);
        data.append(questionText);
        data.append(isActive);
        data.append("TypeInQuestion"); //todo: shortName
        data.append(false);
//        database.insertIntoQuestionTable(data);
        emit newQuestion(data);
        emit questionSaved();
//        QTimer::singleShot(1000, this, [this] { emit questionSaved(); });
    }

    Q_INVOKABLE void saveSingleChoiceQuestion(
            const QString &theme,
            const int difficulty,
            const bool isActive,
            const QString &questionText,
            const QVector<QString> &variants,
            int rightAnswerIndex
    ) {
        qDebug() << "Save single choice question. Text: " << questionText;
        qDebug() << "Theme: '" << theme << "'; difficulty: " << difficulty << "; isActive: " << isActive;
        for (int i = 0; i < variants.size(); i++) {
            qDebug() << "Variant: " << variants[i] << " : " << (i == rightAnswerIndex ? "+" : "-");
        }

        emit saveFailed(tr("I don't want to save this question!"));
    }

    Q_INVOKABLE void saveMultipleChoiceQuestion(
            const QString &theme,
            const int difficulty,
            const bool isActive,
            const QString &questionText,
            const QVector<QString> &variants,
            const QVector<int> &rightAnswerIndices
    ) {
        qDebug() << "Save multiple choice question. Text: " << questionText;
        qDebug() << "Theme: '" << theme << "'; difficulty: " << difficulty << "; isActive: " << isActive;
        for (int i = 0; i < variants.size(); i++) {
            qDebug() << "Variant: " << variants[i] << " : " << (rightAnswerIndices.contains(i) ? "+" : "-");
        }
    }

    Q_INVOKABLE void saveMatchQuestion(
            const QString &theme,
            const int difficulty,
            const bool isActive,
            const QString &questionText,
            const QVector<QString> &leftColumn,
            const QVector<QString> &rightColumn
    ) {
        qDebug() << "Save match question. Text: " << questionText;
        qDebug() << "Theme: '" << theme << "'; difficulty: " << difficulty << "; isActive: " << isActive;

        const QVector<QString> &smaller = leftColumn.size() <= rightColumn.size() ? leftColumn : rightColumn;
        const QVector<QString> &bigger = smaller == leftColumn ? rightColumn : leftColumn;

        for (int i = 0; i < smaller.size(); i++) {
            qDebug() << "Match: " << smaller[i] << " - " << bigger[i];
        }

        for (int i = smaller.size(); i < bigger.size(); ++i) {
            qDebug() << "Not matched: " << bigger[i];
        }
    }

    Q_INVOKABLE void saveTypeInFillQuestion(
            const QString &theme,
            const int difficulty,
            const bool isActive,
            const QString &questionText,
            const QVector<int> &offsets,
            const QVector<QVector<QString>> &answers
    ) {
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
        qDebug() << "Theme: '" << theme << "'; difficulty: " << difficulty << "; isActive: " << isActive;
    }

    Q_INVOKABLE void saveDropDownFillQuestion(
            const QString &theme,
            const int difficulty,
            const bool isActive,
            const QString &questionText,
            const QVector<int> &offsets,
            const QVector<QVector<QString>> &answers,
            const QVector<int> &rightAnswerIndices
    ) {
        QString debugString = questionText;

        int fixer = 0;
        for (int i = 0; i < offsets.size(); ++i) {
            int offset = offsets[i];
            auto listAnswers = answers[i];
            QString gapAnswersString = "[";
            for (int j = 0; j < listAnswers.size(); ++j) {
                gapAnswersString += listAnswers[j] + "(" + (j == rightAnswerIndices[i] ? "+" : "-") + ")" +
                                    (j == listAnswers.size() - 1 ? "" : ", ");
            }
            gapAnswersString += "]";
            debugString.insert(offset + fixer, gapAnswersString);
            fixer += gapAnswersString.size();
        }

        qDebug() << "Save type in fill question. Text: " << debugString;
        qDebug() << "Theme: '" << theme << "'; difficulty: " << difficulty << "; isActive: " << isActive;
    }

    static QuestionSaver* singletonProvider(QQmlEngine* engine, QJSEngine* scriptEngine) {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)

        return new QuestionSaver();
    }

signals:

    void questionSaved();

    void newQuestion(QVariantList data);

    void saveFailed(QString errorMessage);

};

#endif //SOFTWARE_GAME_COMPLEX_QUESTIONSAVER_H
