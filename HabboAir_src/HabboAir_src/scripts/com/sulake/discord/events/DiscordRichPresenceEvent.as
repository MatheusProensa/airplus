package com.sulake.discord.events
{
   import flash.events.Event;
   
   public final class DiscordRichPresenceEvent extends Event
   {
      public static const JOIN:String = "discordActivityJoin";
      
      public static const JOIN_REQUEST:String = "discordActivityJoinRequest";
      
      public static const UnknownConstFromDiscordRichPresenceEvent_String_1:String = "discordActivitySpectate";
      
      public var secret:String;
      
      public var user:Object;
      
      public var payload:Object;
      
      public function DiscordRichPresenceEvent(param1:String, param2:String, param3:Object = null, param4:Object = null)
      {
         super(param1,false,false);
         this.secret = param2;
         this.user = param3;
         this.payload = param4;
      }
      
      override public function clone() : Event
      {
         return new DiscordRichPresenceEvent(type,secret,user,payload);
      }
   }
}

