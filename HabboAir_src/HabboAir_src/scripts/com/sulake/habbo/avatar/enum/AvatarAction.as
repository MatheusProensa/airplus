package com.sulake.habbo.avatar.enum
{
   public class AvatarAction
   {
      public static const SIGN:String = "sign";
      
      public static const SLEEP:String = "Sleep";
      
      public static const CARRY_OBJECT:String = "cri";
      
      public static const USE_OBJECT:String = "usei";
      
      public static const UnknownConstFromUnknownHabboInventory1_Int_1:String = "fx";
      
      public static const TALK:String = "talk";
      
      public static const GESTURE:String = "gest";
      
      public static const UnknownConstFromAvatarAction_String_1:String = "expression";
      
      public static const UnknownConstFromAvatarAction_String_2:String = "vote";
      
      public static const UnknownConstFromRoomSessionDanceEvent_String_1:String = "dance";
      
      public static const TYPING:String = "typing";
      
      public static const MUTED:String = "muted";
      
      public static const PLAYING_GAME:String = "playing_game";
      
      public static const GUIDE_STATUS:String = "guide";
      
      public static const UnknownConstFromAvatarAction_String_3:String = "respect";
      
      public static const EXPRESSION_JUMP:String = "dance";
      
      public static const EXPRESSION_WAVE:String = "wave";
      
      public static const EXPRESSION_BLOW_A_KISS:String = "blow";
      
      public static const EXPRESSION_67:String = "67";
      
      public static const EXPRESSION_LAUGH:String = "laugh";
      
      public static const UnknownConstFromAvatarAction_String_4:String = "cry";
      
      public static const UnknownConstFromAvatarAction_String_5:String = "idle";
      
      public static const EXPRESSION_SNOWBOARD_OLLIE:String = "sbollie";
      
      public static const EXPRESSION_SNOWBORD_360:String = "sb360";
      
      public static const EXPRESSION_RIDE_JUMP:String = "ridejump";
      
      public static const GESTURE_SMILE:String = "sml";
      
      public static const GESTURE_AGGRAVATED:String = "agr";
      
      public static const GESTURE_SURPRISED:String = "srp";
      
      public static const GESTURE_SAD:String = "sad";
      
      public static const PET_GESTURE_JOY:String = "joy";
      
      public static const PET_GESTURE_CRAZY:String = "crz";
      
      public static const PET_GESTURE_TONGUE:String = "tng";
      
      public static const PET_GESTURE_BLINK:String = "eyb";
      
      public static const PET_GESTURE_MISERABLE:String = "mis";
      
      public static const PET_GESTURE_PUZZLED:String = "puz";
      
      public static const POSTURE:String = "posture";
      
      public static const POSTURE_STAND:String = "std";
      
      public static const POSTURE_SIT:String = "sit";
      
      public static const POSTURE_WALK:String = "mv";
      
      public static const POSTURE_LAY:String = "lay";
      
      public static const POSTURE_SWIM:String = "swim";
      
      public static const POSTURE_FLOAT:String = "float";
      
      public static const POSTURE_SNOWWAR_RUN:String = "swrun";
      
      public static const POSTURE_SNOWWAR_DIE_FRONT:String = "swdiefront";
      
      public static const POSTURE_SNOWWAR_DIE_BACK:String = "swdieback";
      
      public static const POSTURE_SNOWWAR_PICK:String = "swpick";
      
      public static const POSTURE_SNOWWAR_THROW:String = "swthrow";
      
      private static const GESTURE_MAP:Array = ["","sml","agr","srp","sad","joy","crz","tng","eyb","mis","puz"];
      
      private static const UnknownConstFromAvatarAction_Array_1:Array = ["","wave","blow","laugh","cry","idle","dance","respect","sbollie","sb360","ridejump"];
      
      public function AvatarAction()
      {
         super();
      }
      
      public static function getExpressionTime(param1:int) : int
      {
         switch(param1)
         {
            case 1:
               return 5000;
            case 2:
               return 1400;
            case 67:
               return 990;
            case 3:
               return 2000;
            case 4:
               return 2000;
            case 5:
               return 0;
            case 6:
               return 700;
            case 7:
               return 2000;
            case 8:
               return 1500;
            case 9:
               return 1500;
            case 10:
               return 1500;
            default:
               return 0;
         }
      }
      
      public static function getExpressionId(param1:String) : int
      {
         if(param1 == "67")
         {
            return 67;
         }
         return UnknownConstFromAvatarAction_Array_1.indexOf(param1);
      }
      
      public static function getExpression(param1:int) : String
      {
         if(param1 == 67)
         {
            return "67";
         }
         if(param1 < UnknownConstFromAvatarAction_Array_1.length)
         {
            return UnknownConstFromAvatarAction_Array_1[param1];
         }
         return "";
      }
      
      public static function getGestureId(param1:String) : int
      {
         return GESTURE_MAP.indexOf(param1);
      }
      
      public static function getGesture(param1:int) : String
      {
         if(param1 < GESTURE_MAP.length)
         {
            return GESTURE_MAP[param1];
         }
         return "";
      }
   }
}

