package com.sulake.habbo.window.utils.tableview
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   
   public class CellTemplate
   {
      private var UnknownVarFromCellTemplate_IRegionWindow_1:IRegionWindow;
      
      private var _highlightBorderTemplate:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromCellTemplate_ITextWindow_1:ITextWindow;
      
      private var UnknownVarFromCellTemplate_ITextFieldWindow_1:ITextFieldWindow;
      
      private var UnknownVarFromCellTemplate_IRegionWindow_2:IRegionWindow;
      
      private var UnknownVarFromCellTemplate_IRegionWindow_3:IRegionWindow;
      
      public function CellTemplate(param1:IRegionWindow)
      {
         super();
         UnknownVarFromCellTemplate_IRegionWindow_1 = param1;
         _highlightBorderTemplate = param1.findChildByName("highlight_border") as UnknownICoreWindowComponents6;
         UnknownVarFromCellTemplate_ITextWindow_1 = param1.findChildByName("element_text") as ITextWindow;
         UnknownVarFromCellTemplate_ITextFieldWindow_1 = param1.findChildByName("element_input") as ITextFieldWindow;
         UnknownVarFromCellTemplate_IRegionWindow_2 = param1.findChildByName("link_container") as IRegionWindow;
         UnknownVarFromCellTemplate_IRegionWindow_3 = param1.findChildByName("extra_button") as IRegionWindow;
         UnknownVarFromCellTemplate_IRegionWindow_1.removeChild(UnknownVarFromCellTemplate_IRegionWindow_3);
         UnknownVarFromCellTemplate_IRegionWindow_1.removeChild(UnknownVarFromCellTemplate_IRegionWindow_2);
         UnknownVarFromCellTemplate_IRegionWindow_1.removeChild(UnknownVarFromCellTemplate_ITextFieldWindow_1);
         UnknownVarFromCellTemplate_IRegionWindow_1.removeChild(UnknownVarFromCellTemplate_ITextWindow_1);
         UnknownVarFromCellTemplate_IRegionWindow_1.removeChild(_highlightBorderTemplate);
      }
      
      public function clone() : IRegionWindow
      {
         return UnknownVarFromCellTemplate_IRegionWindow_1.clone() as IRegionWindow;
      }
      
      public function createHighlightBorder(param1:IWindowController_1) : UnknownICoreWindowComponents6
      {
         return fixAlignmentsAndAdd(_highlightBorderTemplate,param1) as UnknownICoreWindowComponents6;
      }
      
      public function createElementText(param1:IWindowController_1) : ITextWindow
      {
         return fixAlignmentsAndAdd(UnknownVarFromCellTemplate_ITextWindow_1,param1) as ITextWindow;
      }
      
      public function createElementInput(param1:IWindowController_1) : ITextFieldWindow
      {
         return fixAlignmentsAndAdd(UnknownVarFromCellTemplate_ITextFieldWindow_1,param1) as ITextFieldWindow;
      }
      
      public function createLinkContainer(param1:IWindowController_1) : IRegionWindow
      {
         return fixAlignmentsAndAdd(UnknownVarFromCellTemplate_IRegionWindow_2,param1) as IRegionWindow;
      }
      
      public function createExtraButton(param1:IWindowController_1) : IRegionWindow
      {
         return fixAlignmentsAndAdd(UnknownVarFromCellTemplate_IRegionWindow_3,param1) as IRegionWindow;
      }
      
      private function fixAlignmentsAndAdd(param1:IWindowModel, param2:IWindowController_1) : IWindowModel
      {
         var _loc3_:int = param2.width - UnknownVarFromCellTemplate_IRegionWindow_1.width;
         var _loc4_:IWindowModel = param1.clone();
         var _loc5_:uint = param1.param;
         var _loc6_:int = param1.x;
         var _loc8_:int = param1.width;
         var _loc7_:uint = uint(_loc5_ & 0xC0);
         if(_loc7_ == 128)
         {
            _loc8_ += _loc3_;
         }
         else if(_loc7_ == 64)
         {
            _loc6_ += _loc3_;
         }
         else if(_loc7_ == 192)
         {
            if(param2.width < param1.width && param1.getParamFlag(16))
            {
               _loc6_ = 0;
            }
            else
            {
               _loc6_ = Math.floor(param2.width / 2) - Math.floor(_loc8_ / 2);
            }
         }
         _loc4_.x = _loc6_;
         _loc4_.width = _loc8_;
         param2.addChild(_loc4_);
         return _loc4_;
      }
   }
}

