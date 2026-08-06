package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.communication.messages.incoming.competition.IsUserPartOfCompetitionMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToASubmittableRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.competition.GetIsUserPartOfCompetitionMessageComposer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class SubmitCompetitionRoomElementHandler extends AbstractButtonElementHandler
   {
      private var _submittedKey:String;
      
      private var _goalCode:String;
      
      private var UnknownVarFromSubmitCompetitionRoomElementHandler_Boolean_1:Boolean;
      
      private var UnknownVarFromSubmitCompetitionRoomElementHandler_Int_1:int;
      
      public function SubmitCompetitionRoomElementHandler()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         _submittedKey = param3[2];
         _goalCode = param3[3];
         param1.communicationManager.addHabboConnectionMessageEvent(new IsUserPartOfCompetitionMessageEvent(onInfo));
      }
      
      override public function refresh() : void
      {
         super.refresh();
         landingView.send(new GetIsUserPartOfCompetitionMessageComposer(_goalCode));
      }
      
      override protected function onClick() : void
      {
         landingView.questEngine.reenableRoomCompetitionWindow();
         if(UnknownVarFromSubmitCompetitionRoomElementHandler_Boolean_1)
         {
            landingView.navigator.goToPrivateRoom(UnknownVarFromSubmitCompetitionRoomElementHandler_Int_1);
            landingView.tracking.trackGoogle("landingView","click_submittedroom");
         }
         else
         {
            landingView.send(new ForwardToASubmittableRoomMessageComposer());
            landingView.tracking.trackGoogle("landingView","click_startsubmit");
         }
      }
      
      private function onInfo(param1:IsUserPartOfCompetitionMessageEvent) : void
      {
         UnknownVarFromSubmitCompetitionRoomElementHandler_Boolean_1 = param1.getParser().isPartOf;
         UnknownVarFromSubmitCompetitionRoomElementHandler_Int_1 = param1.getParser().targetId;
         if(UnknownVarFromSubmitCompetitionRoomElementHandler_Boolean_1)
         {
            window.caption = "${" + _submittedKey + "}";
         }
      }
   }
}

