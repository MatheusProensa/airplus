package com.sulake.discord
{
   import com.sulake.discord.events.DiscordRichPresenceEvent;
   import flash.events.EventDispatcher;
   import flash.events.StatusEvent;
   import flash.external.ExtensionContext;
   import flash.system.Capabilities;
   
   public final class DiscordRichPresence extends EventDispatcher
   {
      private static const UnknownConstFromDiscordRichPresence_String_1:String = "com.sulake.discord.richpresence";
      
      private static var UnknownVarFromDiscordRichPresence_DiscordRichPresence_1:DiscordRichPresence;
      
      public static const UnknownConstFromDiscordRichPresence_String_2:String = "DISCORD_CONNECTED";
      
      public static const UnknownConstFromDiscordRichPresence_String_3:String = "DISCORD_ERROR";
      
      public static const UnknownConstFromDiscordRichPresence_String_4:String = "DISCORD_SHUTDOWN";
      
      public static const EVENT_ACTIVITY_JOIN:String = "DISCORD_ACTIVITY_JOIN";
      
      public static const EVENT_ACTIVITY_JOIN_REQUEST:String = "DISCORD_ACTIVITY_JOIN_REQUEST";
      
      public static const UnknownConstFromDiscordRichPresence_String_5:String = "DISCORD_ACTIVITY_SPECTATE";
      
      private static const IS_SUPPORTED:Boolean = isDesktopSupported();
      
      private var _context:ExtensionContext;
      
      private var UnknownVarFromDiscordRichPresence_Boolean_1:Boolean;
      
      public function DiscordRichPresence()
      {
         super();
         if(UnknownVarFromDiscordRichPresence_DiscordRichPresence_1)
         {
            throw new Error("DiscordRichPresence is a singleton. Use DiscordRichPresence.instance instead.");
         }
         UnknownVarFromDiscordRichPresence_Boolean_1 = IS_SUPPORTED;
         if(UnknownVarFromDiscordRichPresence_Boolean_1)
         {
            _context = ExtensionContext.createExtensionContext("com.sulake.discord.richpresence",null);
            if(_context)
            {
               _context.addEventListener("status",forwardStatusEvent);
            }
            else
            {
               UnknownVarFromDiscordRichPresence_Boolean_1 = false;
            }
         }
         UnknownVarFromDiscordRichPresence_DiscordRichPresence_1 = this;
      }
      
      public static function get instance() : DiscordRichPresence
      {
         if(!UnknownVarFromDiscordRichPresence_DiscordRichPresence_1)
         {
            UnknownVarFromDiscordRichPresence_DiscordRichPresence_1 = new DiscordRichPresence();
         }
         return UnknownVarFromDiscordRichPresence_DiscordRichPresence_1;
      }
      
      public static function get isSupported() : Boolean
      {
         return IS_SUPPORTED;
      }
      
      private static function isDesktopSupported() : Boolean
      {
         var _loc1_:String = Capabilities.version;
         return _loc1_.indexOf("WIN") == 0 || _loc1_.indexOf("MAC") == 0;
      }
      
      public function dispose() : void
      {
         if(_context)
         {
            _context.removeEventListener("status",forwardStatusEvent);
            _context.dispose();
            _context = null;
         }
         UnknownVarFromDiscordRichPresence_DiscordRichPresence_1 = null;
      }
      
      public function initialize(param1:String) : Boolean
      {
         if(!param1 || param1.length == 0)
         {
            throw new ArgumentError("clientId must be a non-empty string.");
         }
         return Boolean(callContext("initialize",param1));
      }
      
      public function updatePresence(param1:Object) : Boolean
      {
         var _loc2_:String = !!param1 ? JSON.stringify(param1) : "{}";
         return Boolean(callContext("updatePresence",_loc2_));
      }
      
      public function clearPresence() : Boolean
      {
         return Boolean(callContext("clearPresence"));
      }
      
      public function shutdown() : Boolean
      {
         return Boolean(callContext("shutdown"));
      }
      
      public function respondToJoinRequest(param1:String, param2:Boolean) : Boolean
      {
         if(!param1 || param1.length == 0)
         {
            throw new ArgumentError("userId must be a non-empty string.");
         }
         return Boolean(callContext("respondJoinRequest",param1,param2));
      }
      
      public function addStatusListener(param1:Function, param2:Boolean = false) : void
      {
         addEventListener("status",param1,false,0,param2);
      }
      
      public function removeStatusListener(param1:Function) : void
      {
         removeEventListener("status",param1);
      }
      
      public function addJoinListener(param1:Function, param2:Boolean = false) : void
      {
         addEventListener("discordActivityJoin",param1,false,0,param2);
      }
      
      public function removeJoinListener(param1:Function) : void
      {
         removeEventListener("discordActivityJoin",param1);
      }
      
      public function addJoinRequestListener(param1:Function, param2:Boolean = false) : void
      {
         addEventListener("discordActivityJoinRequest",param1,false,0,param2);
      }
      
      public function removeJoinRequestListener(param1:Function) : void
      {
         removeEventListener("discordActivityJoinRequest",param1);
      }
      
      public function addSpectateListener(param1:Function, param2:Boolean = false) : void
      {
         addEventListener("discordActivitySpectate",param1,false,0,param2);
      }
      
      public function removeSpectateListener(param1:Function) : void
      {
         removeEventListener("discordActivitySpectate",param1);
      }
      
      private function callContext(param1:String, ... rest) : Object
      {
         if(!UnknownVarFromDiscordRichPresence_Boolean_1)
         {
            return false;
         }
         if(!_context)
         {
            throw new Error("Extension context has been disposed.");
         }
         return _context.call.apply(_context,[param1].concat(rest));
      }
      
      private function forwardStatusEvent(param1:StatusEvent) : void
      {
         dispatchEvent(param1);
         switch(param1.code)
         {
            case "DISCORD_ACTIVITY_JOIN":
               dispatchJoinEvent(param1.level);
               break;
            case "DISCORD_ACTIVITY_JOIN_REQUEST":
               dispatchJoinRequestEvent(param1.level);
               break;
            case "DISCORD_ACTIVITY_SPECTATE":
               dispatchSpectateEvent(param1.level);
         }
      }
      
      private function dispatchJoinEvent(param1:String) : void
      {
         var _loc2_:Object = extractPayloadData(param1);
         if(!_loc2_ || !_loc2_.secret)
         {
            return;
         }
         var _loc3_:DiscordRichPresenceEvent = new DiscordRichPresenceEvent("discordActivityJoin",_loc2_.secret,null,_loc2_);
         dispatchEvent(_loc3_);
      }
      
      private function dispatchJoinRequestEvent(param1:String) : void
      {
         var _loc3_:Object = extractPayloadData(param1);
         if(!_loc3_ || !_loc3_.user)
         {
            return;
         }
         var _loc2_:DiscordRichPresenceEvent = new DiscordRichPresenceEvent("discordActivityJoinRequest",!!_loc3_.secret ? _loc3_.secret : "",_loc3_.user,_loc3_);
         dispatchEvent(_loc2_);
      }
      
      private function dispatchSpectateEvent(param1:String) : void
      {
         var _loc2_:Object = extractPayloadData(param1);
         if(!_loc2_ || !_loc2_.secret)
         {
            return;
         }
         var _loc3_:DiscordRichPresenceEvent = new DiscordRichPresenceEvent("discordActivitySpectate",_loc2_.secret,null,_loc2_);
         dispatchEvent(_loc3_);
      }
      
      private function extractPayloadData(param1:String) : Object
      {
         if(!param1 || param1.length == 0)
         {
            return null;
         }
         var _loc2_:Object = safeParse(param1);
         if(!_loc2_ || !_loc2_.data)
         {
            return null;
         }
         return _loc2_.data;
      }
      
      private function safeParse(param1:String) : Object
      {
         try
         {
            return JSON.parse(param1);
         }
         catch(error:Error)
         {
            var _loc4_:* = null;
         }
         return _loc4_;
      }
   }
}

