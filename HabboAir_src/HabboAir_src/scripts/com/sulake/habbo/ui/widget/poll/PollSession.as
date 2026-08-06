package com.sulake.habbo.ui.widget.poll
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   
   public class PollSession implements IComponentInterfaceQueue
   {
      private var _id:int = -1;
      
      private var UnknownVarFromPollSession_PollWidget_1:PollWidget;
      
      private var UnknownVarFromPollSession_IPollOfferDialog_1:IPollOfferDialog;
      
      private var UnknownVarFromPollSession_IPollOfferDialog_2:IPollOfferDialog;
      
      private var _endMessage:String = "";
      
      private var _disposed:Boolean = false;
      
      public function PollSession(param1:int, param2:PollWidget)
      {
         super();
         _id = param1;
         UnknownVarFromPollSession_PollWidget_1 = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(UnknownVarFromPollSession_IPollOfferDialog_1 != null)
         {
            UnknownVarFromPollSession_IPollOfferDialog_1.dispose();
            UnknownVarFromPollSession_IPollOfferDialog_1 = null;
         }
         if(UnknownVarFromPollSession_IPollOfferDialog_2 != null)
         {
            UnknownVarFromPollSession_IPollOfferDialog_2.dispose();
            UnknownVarFromPollSession_IPollOfferDialog_2 = null;
         }
         UnknownVarFromPollSession_PollWidget_1 = null;
         _disposed = true;
      }
      
      public function showOffer(param1:String, param2:String) : void
      {
         hideOffer();
         UnknownVarFromPollSession_IPollOfferDialog_1 = new PollOfferDialog(_id,param1,param2,UnknownVarFromPollSession_PollWidget_1);
         UnknownVarFromPollSession_IPollOfferDialog_1.start();
      }
      
      public function hideOffer() : void
      {
         if(UnknownVarFromPollSession_IPollOfferDialog_1 is PollOfferDialog)
         {
            if(!UnknownVarFromPollSession_IPollOfferDialog_1.disposed)
            {
               UnknownVarFromPollSession_IPollOfferDialog_1.dispose();
            }
            UnknownVarFromPollSession_IPollOfferDialog_1 = null;
         }
      }
      
      public function showContent(param1:String, param2:String, param3:Array, param4:Boolean) : void
      {
         hideOffer();
         hideContent();
         _endMessage = param2;
         UnknownVarFromPollSession_IPollOfferDialog_2 = new PollContentDialog(_id,param1,param3,UnknownVarFromPollSession_PollWidget_1,param4);
         UnknownVarFromPollSession_IPollOfferDialog_2.start();
      }
      
      public function hideContent() : void
      {
         if(UnknownVarFromPollSession_IPollOfferDialog_2 is PollContentDialog)
         {
            if(!UnknownVarFromPollSession_IPollOfferDialog_2.disposed)
            {
               UnknownVarFromPollSession_IPollOfferDialog_2.dispose();
            }
            UnknownVarFromPollSession_IPollOfferDialog_2 = null;
         }
      }
      
      public function showThanks() : void
      {
         UnknownVarFromPollSession_PollWidget_1.windowManager.alert("${poll_thanks_title}",_endMessage,0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
   }
}

