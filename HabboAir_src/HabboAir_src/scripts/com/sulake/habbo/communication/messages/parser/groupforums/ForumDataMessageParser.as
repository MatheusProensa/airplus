package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ForumDataMessageParser implements IMessageParser
   {
      private var _forumData:ExtendedForumData;
      
      public function ForumDataMessageParser()
      {
         super();
      }
      
      public function get forumData() : ExtendedForumData
      {
         return _forumData;
      }
      
      public function flush() : Boolean
      {
         _forumData = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _forumData = ExtendedForumData.readFromMessage(param1);
         return true;
      }
   }
}

