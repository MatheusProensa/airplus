package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   
   public class UnknownHabboFriendbarLandingviewWidgetElements1
   {
      public static const CAPTION:String = "caption";
      
      public static const TITLE:String = "title";
      
      public static const UnknownConstFromUnknownHabboFriendbarLandingviewWidgetElements1_String_1:String = "subcaption";
      
      public static const BODYTEXT:String = "bodytext";
      
      public static const SPACING:String = "spacing";
      
      public static const CATALOGBUTTON:String = "catalogbutton";
      
      public static const PROMOTEDROOMBUTTON:String = "promotedroombutton";
      
      public static const LINK:String = "link";
      
      public static const UnknownConstFromUnknownHabboFriendbarLandingviewWidgetElements1_String_2:String = "gotoroombutton";
      
      public static const REQUESTBADGEBUTTON:String = "requestbadgebutton";
      
      public static const REQUESTBADGEBUTTONSECOND:String = "requestbadgebuttonsecond";
      
      public static const REQUESTBADGEBUTTONTHIRD:String = "requestbadgebuttonthird";
      
      public static const REQUESTBADGEBUTTONFOURTH:String = "requestbadgebuttonfourth";
      
      public static const REQUESTBADGEBUTTONFIFTH:String = "requestbadgebuttonfifth";
      
      public static const CREDITHABBLETBUTTON:String = "credithabbletbutton";
      
      public static const COMMUNITYGOALTIMER:String = "communitygoaltimer";
      
      public static const CUSTOMTIMER:String = "customtimer";
      
      public static const UnknownConstFromUnknownHabboFriendbarLandingviewWidgetElements1_String_3:String = "gotohomeroombutton";
      
      public static const UnknownConstFromUnknownHabboFriendbarLandingviewWidgetElements1_String_4:String = "gotocompetitionroombutton";
      
      public static const REWARDBADGE:String = "rewardbadge";
      
      public static const IMAGE:String = "image";
      
      public static const SUBMITCOMPETITIONROOM:String = "submitcompetitionroom";
      
      public static const CONCURRENTUSERSMETER:String = "concurrentusersmeter";
      
      public static const CONCURRENTUSERSINFO:String = "concurrentusersinfo";
      
      public static const DAILYQUEST:String = "dailyquest";
      
      public static const UnknownConstFromUnknownHabboFriendbarLandingviewWidgetElements1_String_5:String = "buyvipbutton";
      
      public static const COMMUNITYGOALSCORE:String = "communitygoalscore";
      
      public static const INTERNAL_LINK_BUTTON:String = "internallinkbutton";
      
      public function UnknownHabboFriendbarLandingviewWidgetElements1()
      {
         super();
      }
      
      public static function createHandler(param1:String) : IElementHandler
      {
         switch(param1)
         {
            case "caption":
            case "subcaption":
            case "bodytext":
               return new TextElementHandler();
            case "title":
               return new TitleElementHandler();
            case "spacing":
               return new UnknownHabboFriendbarLandingviewWidgetElements5();
            case "catalogbutton":
               return new CatalogButtonElementHandler();
            case "promotedroombutton":
               return new PromotedRoomButtonElementHandler();
            case "link":
               return new LinkElementHandler();
            case "gotoroombutton":
               return new GoToRoomButtonElementHandler();
            case "requestbadgebutton":
            case "requestbadgebuttonsecond":
            case "requestbadgebuttonthird":
            case "requestbadgebuttonfourth":
            case "requestbadgebuttonfifth":
               break;
            case "credithabbletbutton":
               return new UnknownHabboFriendbarLandingviewWidgetElements2();
            case "communitygoaltimer":
               return new CommunityGoalTimerElementHandler();
            case "customtimer":
               return new CustomTimerElementHandler();
            case "gotohomeroombutton":
               return new UnknownHabboFriendbarLandingviewWidgetElements4();
            case "gotocompetitionroombutton":
               return new GoToCompetitionRoomButtonElementHandler();
            case "rewardbadge":
               return new UnknownHabboFriendbarLandingviewWidgetElements3();
            case "image":
               return new UnknownHabboFriendbarLandingviewWidgetElements7();
            case "submitcompetitionroom":
               return new SubmitCompetitionRoomElementHandler();
            case "concurrentusersmeter":
               return new ConcurrentUsersMeterElementHandler();
            case "concurrentusersinfo":
               return new ConcurrentUsersInfoElementHandler();
            case "dailyquest":
               return new DailyQuestElementHandler();
            case "buyvipbutton":
               return new UnknownHabboFriendbarLandingviewWidgetElements6();
            case "communitygoalscore":
               return new CommunityGoalScoreCounterElementHandler();
            case "internallinkbutton":
               return new InternalLinkButtonElementHandler();
            default:
               return null;
         }
         return new RequestBadgeButtonElementHandler();
      }
   }
}

