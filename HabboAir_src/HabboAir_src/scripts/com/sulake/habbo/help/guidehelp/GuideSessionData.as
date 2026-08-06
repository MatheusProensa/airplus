package com.sulake.habbo.help.guidehelp
{
   public class GuideSessionData
   {
      public static const ROLE_UNDECIDED:uint = 0;
      
      public static const ROLE_GUIDE:uint = 1;
      
      public static const ROLE_USER:uint = 2;
      
      public static const UnknownConstFromGuideSessionData_Int_1:int = 0;
      
      public static const UnknownConstFromGuideSessionData_Int_2:int = 1;
      
      public static const UnknownConstFromGuideSessionData_Int_3:int = 2;
      
      private var UnknownVarFromGuideSessionData_Uint_1:uint = 0;
      
      private var _activeWindow:String = "";
      
      private var _requestType:uint = 0;
      
      private var _requestDescription:String = "";
      
      private var _userId:uint = 0;
      
      private var _userName:String = "";
      
      private var _userFigure:String = "";
      
      private var _guideId:uint = 0;
      
      private var _guideName:String = "";
      
      private var _guideFigure:String = "";
      
      public function GuideSessionData()
      {
         super();
      }
      
      public function isActiveSession() : Boolean
      {
         return isActiveUserSession() || isActiveGuideSession();
      }
      
      public function isActiveUserSession() : Boolean
      {
         return UnknownVarFromGuideSessionData_Uint_1 == 2 && (_activeWindow == "user_create" || _activeWindow == "user_pending" || _activeWindow == "user_ongoing" || _activeWindow == "user_feedback");
      }
      
      public function isActiveGuideSession() : Boolean
      {
         return UnknownVarFromGuideSessionData_Uint_1 == 1 && (_activeWindow == "guide_accept" || _activeWindow == "guide_ongoing" || _activeWindow == "guide_closed");
      }
      
      public function isOnGoingSession() : Boolean
      {
         return _activeWindow == "guide_ongoing" || _activeWindow == "user_ongoing";
      }
      
      public function set role(param1:uint) : void
      {
         UnknownVarFromGuideSessionData_Uint_1 = param1;
      }
      
      public function get activeWindow() : String
      {
         return _activeWindow;
      }
      
      public function set activeWindow(param1:String) : void
      {
         _activeWindow = param1;
      }
      
      public function get requestType() : uint
      {
         return _requestType;
      }
      
      public function set requestType(param1:uint) : void
      {
         _requestType = param1;
      }
      
      public function get requestDescription() : String
      {
         return _requestDescription;
      }
      
      public function set requestDescription(param1:String) : void
      {
         _requestDescription = param1;
      }
      
      public function get userId() : uint
      {
         return _userId;
      }
      
      public function set userId(param1:uint) : void
      {
         _userId = param1;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function set userName(param1:String) : void
      {
         _userName = param1;
      }
      
      public function get userFigure() : String
      {
         return _userFigure;
      }
      
      public function set userFigure(param1:String) : void
      {
         _userFigure = param1;
      }
      
      public function get guideId() : uint
      {
         return _guideId;
      }
      
      public function set guideId(param1:uint) : void
      {
         _guideId = param1;
      }
      
      public function get guideName() : String
      {
         return _guideName;
      }
      
      public function set guideName(param1:String) : void
      {
         _guideName = param1;
      }
      
      public function get guideFigure() : String
      {
         return _guideFigure;
      }
      
      public function set guideFigure(param1:String) : void
      {
         _guideFigure = param1;
      }
   }
}

