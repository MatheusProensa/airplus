package
{
   import com.sulake.bootstrap.HabboQuestEngineBootstrap;
   import com.sulake.iid.IIDHabboQuestEngine;
   import mx.core.SimpleApplication;
   
   [SecureSWF(rename="false")]
   public class HabboQuestEngineCom extends SimpleApplication
   {
      public static var manifest:Class = manifest_16_xml;
      
      public static var requiredClasses:Array = new Array(HabboQuestEngineBootstrap,IIDHabboQuestEngine);
      
      public static const icon_quest_hidden:Class = icon_quest_hidden_1_png;
      
      public static const Campaign:Class = Campaign_1_xml;
      
      public static const CampaignCompleted:Class = CampaignCompleted_1_xml;
      
      public static const EntryArrows:Class = EntryArrows_1_xml;
      
      public static const QuestEntry:Class = QuestEntry_1_xml;
      
      public static const Quest:Class = Quest_1_xml;
      
      public static const QuestDetails:Class = QuestDetails_1_xml;
      
      public static const Quests:Class = Quests_1_xml;
      
      public static const QuestTracker:Class = QuestTracker_1_xml;
      
      public static const QuestCompletedDialog:Class = QuestCompletedDialog_1_xml;
      
      public static const QuestHelp:Class = QuestHelp_1_xml;
      
      public static const AchievementCategory:Class = AchievementCategory_1_xml;
      
      public static const Achievements:Class = Achievements_1_xml;
      
      public static const AchievementsResolutions:Class = AchievementsResolutions_1_xml;
      
      public static const AchievementResolutionProgress:Class = AchievementResolutionProgress_1_xml;
      
      public static const AchievementResolutionCompleted:Class = AchievementResolutionCompleted_1_xml;
      
      public static const Achievement:Class = Achievement_1_xml;
      
      public static const AchievementSimple:Class = AchievementSimple_1_xml;
      
      public static const ProgressBar:Class = ProgressBar_1_xml;
      
      public static const NextQuestTimer:Class = NextQuestTimer_1_xml;
      
      public static const SeasonalCalendar:Class = SeasonalCalendar_1_xml;
      
      public static const RoomCompetition:Class = RoomCompetition_1_xml;
      
      public static const calendar_quest_complete:Class = calendar_quest_complete_1_png;
      
      public static const arrow_back_active:Class = arrow_back_active_1_png;
      
      public static const arrow_back_inactive:Class = arrow_back_inactive_1_png;
      
      public static const arrow_back_hilite:Class = arrow_back_hilite_1_png;
      
      public static const arrow_next_active:Class = arrow_next_active_1_png;
      
      public static const arrow_next_inactive:Class = arrow_next_inactive_1_png;
      
      public static const arrow_next_hilite:Class = arrow_next_hilite_1_png;
      
      public static const stripe_mask_L:Class = stripe_mask_L_1_png;
      
      public static const stripe_mask_R:Class = stripe_mask_R_1_png;
      
      public static var icon_hourglass_png:Class = icon_hourglass_1_png;
      
      public static const daily_tasks_xml:Class = dailytasks_1_xml;
      
      public static const dailytasks_unclaimed_xml:Class = dailytasks_unclaimed_1_xml;
      
      public static const reward_track_main_xml:Class = main_2_xml;
      
      public static const reward_track_premium_purchase_confirmation_xml:Class = premium_purchase_confirmation_1_xml;
      
      public function HabboQuestEngineCom()
      {
         super();
      }
   }
}

