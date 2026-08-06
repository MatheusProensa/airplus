package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredEnvironmentMessageParser implements IMessageParser
   {
      private var _hasClickUserWired:Boolean;
      
      private var _enabledAchievements:Vector.<String>;
      
      public function WiredEnvironmentMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _hasClickUserWired = false;
         _enabledAchievements = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _hasClickUserWired = param1.readBoolean();
         _enabledAchievements = new Vector.<String>();
         if(param1.bytesAvailable > 0)
         {
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _enabledAchievements.push(param1.readString());
               _loc3_ += 1;
            }
         }
         return true;
      }
      
      public function get hasClickUserWired() : Boolean
      {
         return _hasClickUserWired;
      }
      
      public function get enabledAchievements() : Vector.<String>
      {
         return _enabledAchievements;
      }
   }
}

