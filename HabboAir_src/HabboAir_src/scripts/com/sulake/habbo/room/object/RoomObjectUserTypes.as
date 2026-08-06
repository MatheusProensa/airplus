package com.sulake.habbo.room.object
{
   import flash.utils.Dictionary;
   
   public class RoomObjectUserTypes
   {
      public static const USER:String = "user";
      
      public static const PET:String = "pet";
      
      public static const BOT:String = "bot";
      
      public static const RENTABLE_BOT:String = "rentable_bot";
      
      public static const MONSTERPLANT:String = "monsterplant";
      
      private static const UnknownConstFromRoomObjectUserTypes_Dictionary_1:Dictionary = new Dictionary();
      
      UnknownConstFromRoomObjectUserTypes_Dictionary_1["user"] = 1;
      UnknownConstFromRoomObjectUserTypes_Dictionary_1["pet"] = 2;
      UnknownConstFromRoomObjectUserTypes_Dictionary_1["bot"] = 3;
      UnknownConstFromRoomObjectUserTypes_Dictionary_1["rentable_bot"] = 4;
      
      public function RoomObjectUserTypes()
      {
         super();
      }
      
      public static function getTypeId(param1:String) : int
      {
         return UnknownConstFromRoomObjectUserTypes_Dictionary_1[param1];
      }
      
      public static function getName(param1:int) : String
      {
         for(var _loc2_ in UnknownConstFromRoomObjectUserTypes_Dictionary_1)
         {
            if(UnknownConstFromRoomObjectUserTypes_Dictionary_1[_loc2_] == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getVisualizationType(param1:String) : String
      {
         switch(param1)
         {
            case "bot":
            case "rentable_bot":
               break;
            default:
               return param1;
         }
         return "user";
      }
   }
}

