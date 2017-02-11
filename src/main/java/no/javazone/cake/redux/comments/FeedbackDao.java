package no.javazone.cake.redux.comments;

import no.javazone.cake.redux.Configuration;

import java.util.stream.Stream;

public interface FeedbackDao {
    void addFeedback(Feedback feedback);
    void deleteFeedback(String talkRef,String id);
    Stream<Feedback> feedbacksForTalk(String talkid);

    static FeedbackDao instance() {
        switch (Configuration.feedbackDaoImpl()) {
            case "file":
                return FeedbackDaoFileImpl.get();
            case "sleepingpill":
            default:
                return FeedbackInSleepingpill.get();
        }
    }

}
