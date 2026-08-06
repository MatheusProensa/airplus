package com.sulake.habbo.discord.habbo_activity
{
   public class HabboActivityState
   {
      public static const CHILLING:HabboActivityState = new HabboActivityState("chilling",0);
      
      public static const GAMING:HabboActivityState = new HabboActivityState("gaming",104);
      
      public static const WORKING:HabboActivityState = new HabboActivityState("working",103);
      
      public static const RPG:HabboActivityState = new HabboActivityState("rpg",102);
      
      public static const PARTYING:HabboActivityState = new HabboActivityState("partying",100);
      
      public static const TRADING:HabboActivityState = new HabboActivityState("trading",202);
      
      public static const DANCING:HabboActivityState = new HabboActivityState("dancing",201);
      
      public static const BUILDING:HabboActivityState = new HabboActivityState("building",300);
      
      public static const CREATING_WIRED:HabboActivityState = new HabboActivityState("creating_wired",301);
      
      public static const CHATTING:HabboActivityState = new HabboActivityState("chatting",101);
      
      private var _name:String;
      
      private var _rank:int;
      
      public function HabboActivityState(param1:String, param2:int)
      {
         super();
         _name = param1;
         _rank = param2;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get rank() : int
      {
         return _rank;
      }
   }
}

