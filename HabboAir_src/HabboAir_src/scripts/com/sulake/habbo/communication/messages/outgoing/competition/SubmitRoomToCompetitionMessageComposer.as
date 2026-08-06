package com.sulake.habbo.communication.messages.outgoing.competition
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SubmitRoomToCompetitionMessageComposer implements IMessageComposer
   {
      public static const UnknownConstFromSubmitRoomToCompetitionMessageComposer_Int_1:int = 0;
      
      public static const UnknownConstFromSubmitRoomToCompetitionMessageComposer_Int_2:int = 1;
      
      public static const UnknownConstFromSubmitRoomToCompetitionMessageComposer_Int_3:int = 2;
      
      public static const UnknownConstFromSubmitRoomToCompetitionMessageComposer_Int_4:int = 3;
      
      private var _messageArray:Array = [];
      
      public function SubmitRoomToCompetitionMessageComposer(param1:String, param2:int)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
         _messageArray = null;
      }
   }
}

