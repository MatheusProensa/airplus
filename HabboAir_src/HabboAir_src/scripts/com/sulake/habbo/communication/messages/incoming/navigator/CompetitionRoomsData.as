package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class CompetitionRoomsData
   {
      private var _goalId:int;
      
      private var _pageIndex:int;
      
      private var _pageCount:int;
      
      public function CompetitionRoomsData(param1:IMessageDataWrapper, param2:int = 0, param3:int = 0)
      {
         super();
         _goalId = param2;
         _pageIndex = param3;
         if(param1 != null)
         {
            _goalId = param1.readInteger();
            _pageIndex = param1.readInteger();
            _pageCount = param1.readInteger();
         }
      }
      
      public function get goalId() : int
      {
         return _goalId;
      }
      
      public function get pageIndex() : int
      {
         return _pageIndex;
      }
      
      public function get pageCount() : int
      {
         return _pageCount;
      }
   }
}

