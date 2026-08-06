package com.sulake.habbo.communication.messages.parser.poll
{
   [SecureSWF(rename="true")]
   public class PollQuestion
   {
      public static const UnknownConstFromPollQuestion_Int_1:int = 0;
      
      public static const UnknownConstFromPollQuestion_Int_2:int = 1;
      
      public static const UnknownConstFromPollQuestion_Int_3:int = 2;
      
      public static const UnknownConstFromPollQuestion_Int_4:int = 3;
      
      private var _questionId:int;
      
      private var _questionType:int;
      
      private var _sortOrder:int;
      
      private var _questionCategory:int;
      
      private var _questionText:String;
      
      private var _questionAnswerType:int;
      
      private var _questionAnswerCount:int;
      
      private var _children:Vector.<PollQuestion>;
      
      private var _questionChoices:Vector.<PollChoice>;
      
      public function PollQuestion()
      {
         super();
         _children = new Vector.<PollQuestion>();
         _questionChoices = new Vector.<PollChoice>();
      }
      
      public function get questionId() : int
      {
         return _questionId;
      }
      
      public function set questionId(param1:int) : void
      {
         _questionId = param1;
      }
      
      public function get questionType() : int
      {
         return _questionType;
      }
      
      public function set questionType(param1:int) : void
      {
         _questionType = param1;
      }
      
      public function get sortOrder() : int
      {
         return _sortOrder;
      }
      
      public function set sortOrder(param1:int) : void
      {
         _sortOrder = param1;
      }
      
      public function get questionText() : String
      {
         return _questionText;
      }
      
      public function set questionText(param1:String) : void
      {
         _questionText = param1;
      }
      
      public function get questionCategory() : int
      {
         return _questionCategory;
      }
      
      public function set questionCategory(param1:int) : void
      {
         _questionCategory = param1;
      }
      
      public function get questionAnswerType() : int
      {
         return _questionAnswerType;
      }
      
      public function set questionAnswerType(param1:int) : void
      {
         _questionAnswerType = param1;
      }
      
      public function get questionAnswerCount() : int
      {
         return _questionAnswerCount;
      }
      
      public function set questionAnswerCount(param1:int) : void
      {
         _questionAnswerCount = param1;
      }
      
      public function get children() : Vector.<PollQuestion>
      {
         return _children;
      }
      
      public function set children(param1:Vector.<PollQuestion>) : void
      {
         _children = param1;
      }
      
      public function get questionChoices() : Vector.<PollChoice>
      {
         return _questionChoices;
      }
      
      public function set questionChoices(param1:Vector.<PollChoice>) : void
      {
         _questionChoices = param1;
      }
   }
}

