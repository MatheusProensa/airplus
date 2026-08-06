package com.sulake.habbo.help
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.window.widgets.IProgressIndicatorWidget;
   
   public class HabboWayController
   {
      private const START_PAGE:int = 0;
      
      private var UnknownVarFromHabboWayController_Int_1:int = 0;
      
      private var UnknownVarFromHabboWayController_Int_2:int = 0;
      
      private var _habboHelp:HabboHelp;
      
      private var UnknownVarFromHabboWayController_IModalDialog_1:IModalDialog;
      
      private var _window:IWindowController_1;
      
      private var _disposed:Boolean = false;
      
      public function HabboWayController(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            closeWindow();
            if(_habboHelp)
            {
               _habboHelp = null;
            }
            _disposed = true;
         }
      }
      
      private function get finalPage() : int
      {
         return _habboHelp.getInteger("help.habboway.page.count",6);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function showHabboWay() : void
      {
         closeWindow();
         UnknownVarFromHabboWayController_IModalDialog_1 = _habboHelp.getModalXmlWindow("habbo_way");
         _window = IWindowController_1(UnknownVarFromHabboWayController_IModalDialog_1.rootWindow);
         _window.procedure = onWindowEvent;
         IProgressIndicatorWidget(IWidgetWindowController(_window.findChildByName("page_widget")).widget).size = finalPage;
         setCurrentPage(0);
      }
      
      public function closeWindow() : void
      {
         _window = null;
         if(UnknownVarFromHabboWayController_IModalDialog_1)
         {
            UnknownVarFromHabboWayController_IModalDialog_1.dispose();
            UnknownVarFromHabboWayController_IModalDialog_1 = null;
         }
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(_disposed || !_window || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               closeWindow();
               break;
            case "next_button":
               setCurrentPage(Math.min(finalPage,UnknownVarFromHabboWayController_Int_2 + 1));
               _habboHelp.trackGoogle("habboWay","clickNextPage_" + UnknownVarFromHabboWayController_Int_2);
               break;
            case "back_button":
            case "previous_button":
               setCurrentPage(Math.max(0,UnknownVarFromHabboWayController_Int_2 - 1));
               _habboHelp.trackGoogle("habboWay","clickPrevPage_" + UnknownVarFromHabboWayController_Int_2);
               break;
            case "quiz_button":
               _habboHelp.trackGoogle("habboWay","clickQuiz");
               _habboHelp.showHabboWayQuiz();
         }
      }
      
      private function setCurrentPage(param1:int) : void
      {
         UnknownVarFromHabboWayController_Int_2 = param1;
         if(UnknownVarFromHabboWayController_Int_2 < finalPage)
         {
            if(UnknownVarFromHabboWayController_Int_2 == 0)
            {
               _window.findChildByName("previous_button").visible = false;
            }
            else
            {
               _window.findChildByName("previous_button").visible = true;
            }
            IStaticBitmapWrapperWindow(_window.findChildByName("illustration")).assetUri = "${image.library.url}habboway/page_" + UnknownVarFromHabboWayController_Int_2 + ".png";
            IStaticBitmapWrapperWindow(_window.findChildByName("dove_image")).assetUri = "help_habboway_dove_off";
            IProgressIndicatorWidget(IWidgetWindowController(_window.findChildByName("page_widget")).widget).position = UnknownVarFromHabboWayController_Int_2 + 1;
            _window.findChildByName("correct_title").caption = "${habbo.way.page." + UnknownVarFromHabboWayController_Int_2 + ".correct.title}";
            _window.findChildByName("correct_description").caption = "${habbo.way.page." + UnknownVarFromHabboWayController_Int_2 + ".correct.description}";
            _window.findChildByName("wrong_title").caption = "${habbo.way.page." + UnknownVarFromHabboWayController_Int_2 + ".wrong.title}";
            _window.findChildByName("wrong_description").caption = "${habbo.way.page." + UnknownVarFromHabboWayController_Int_2 + ".wrong.description}";
            _window.findChildByName("page_container").visible = true;
            _window.findChildByName("final_page").visible = false;
            _window.findChildByName("page_container").invalidate();
         }
         else
         {
            IStaticBitmapWrapperWindow(_window.findChildByName("illustration")).assetUri = "${image.library.url}habboway/page_end.png";
            IStaticBitmapWrapperWindow(_window.findChildByName("dove_image")).assetUri = "help_habboway_dove_on";
            IProgressIndicatorWidget(IWidgetWindowController(_window.findChildByName("page_widget")).widget).position = 0;
            _window.findChildByName("page_container").visible = false;
            _window.findChildByName("final_page").visible = true;
            _window.findChildByName("final_page").invalidate();
         }
      }
   }
}

