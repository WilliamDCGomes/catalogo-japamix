import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/helpers/loading.dart';
import '../../../utils/helpers/masks_for_text_fields.dart';
import '../../../utils/helpers/platform_type.dart';
import '../../../utils/helpers/text_field_validators.dart';
import '../../../utils/sharedWidgets/dropdown_button_widget.dart';
import '../../../utils/sharedWidgets/text_field_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controllers/register_user_controller.dart';

class BodyRegisterStepperWidget extends StatefulWidget {
  final RegisterUserController controller;
  final int indexView;

  const BodyRegisterStepperWidget(
  { Key? key,
    required this.controller,
    required this.indexView,
  }) : super(key: key);

  @override
  State<BodyRegisterStepperWidget> createState() => _BodyRegisterStepperWidgetState();
}

class _BodyRegisterStepperWidgetState extends State<BodyRegisterStepperWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, bottom: 5.h),
      child: Column(
        children: [
          // Entrys da primeira stepper
          Visibility(
            visible: widget.indexView == 0,
            child: Form(
              key: widget.controller.formKeyPersonalInformation,
              child: Column(
                children: [
                  Obx(
                    () => TextFieldWidget(
                      controller: widget.controller.nameTextController,
                      hintText: "Nome",
                      textCapitalization: TextCapitalization.words,
                      height: PlatformType.isTablet(context) ? 7.h : 9.h,
                      width: double.infinity,
                      keyboardType: TextInputType.name,
                      enableSuggestions: true,
                      textInputAction: TextInputAction.next,
                      hasError: widget.controller.nameInputHasError.value,
                      validator: (String? value) {
                        String? validation = TextFieldValidators.standardValidation(value, "Informe o seu Nome");
                        if(validation != null && validation != ""){
                          widget.controller.nameInputHasError.value = true;
                        }
                        else{
                          widget.controller.nameInputHasError.value = false;
                        }
                        return validation;
                      },
                      onEditingComplete: (){
                        widget.controller.birthDateFocusNode.requestFocus();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.h),
                    child: Obx(
                      () => TextFieldWidget(
                        focusNode: widget.controller.birthDateFocusNode,
                        controller: widget.controller.birthDateTextController,
                        hintText: "Data de Nascimento",
                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                        width: double.infinity,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maskTextInputFormatter: [MasksForTextFields.birthDateMask],
                        hasError: widget.controller.birthdayInputHasError.value,
                        validator: (String? value) {
                          String? validation = TextFieldValidators.birthDayValidation(value, "de Nascimento");
                          if(validation != null && validation != ""){
                            widget.controller.birthdayInputHasError.value = true;
                          }
                          else{
                            widget.controller.birthdayInputHasError.value = false;
                          }
                          return validation;
                        },
                        onEditingComplete: (){
                          widget.controller.cpfFocusNode.requestFocus();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.h),
                    child: Obx(
                      () => TextFieldWidget(
                        focusNode: widget.controller.cpfFocusNode,
                        controller: widget.controller.cpfTextController,
                        hintText: "CPF",
                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                        width: double.infinity,
                        keyboardType: TextInputType.number,
                        maskTextInputFormatter: [MasksForTextFields.cpfMask],
                        hasError: widget.controller.cpfInputHasError.value,
                        validator: (String? value) {
                          String? validation = TextFieldValidators.cpfValidation(value);
                          if(validation != null && validation != ""){
                            widget.controller.cpfInputHasError.value = true;
                          }
                          else{
                            widget.controller.cpfInputHasError.value = false;
                          }
                          return validation;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.h),
                    child: Obx(
                      () => DropdownButtonWidget(
                        itemSelected: widget.controller.genderSelected.value == "" ? null : widget.controller.genderSelected.value,
                        hintText: "Sexo",
                        height: PlatformType.isTablet(context) ? 5.h : 6.5.h,
                        width: 90.w,
                        listItems: widget.controller.genderList,
                        onChanged: (selectedState) {
                          widget.controller.genderSelected.value = selectedState ?? "";
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Entrys da segunda stepper
          Visibility(
            visible: widget.indexView == 1,
            child: Form(
              key: widget.controller.formKeyAddressInformation,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: .5.h),
                    child: Obx(
                      () => TextFieldWidget(
                        controller: widget.controller.cepTextController,
                        hintText: "Cep",
                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                        width: double.infinity,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maskTextInputFormatter: [MasksForTextFields.cepMask],
                        hasError: widget.controller.cepInputHasError.value,
                        onChanged: (value) async {
                          if(value.length == 9){
                            await Loading.startAndPauseLoading(
                              () => widget.controller.searchAddressInformation(),
                              widget.controller.loadingWithSuccessOrErrorWidget,
                            );
                          }
                        },
                        validator: (String? value) {
                          String? validation = TextFieldValidators.minimumNumberValidation(value, 9, "Cep");
                          if(validation != null && validation != ""){
                            widget.controller.cepInputHasError.value = true;
                          }
                          else{
                            widget.controller.cepInputHasError.value = false;
                          }
                          return validation;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.h),
                    child: Obx(
                      () => SizedBox(
                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: 2.w,
                                bottom: PlatformType.isTablet(context) ? 1.7.h : 2.6.h,
                              ),
                              child: DropdownButtonWidget(
                                itemSelected: widget.controller.ufSelected.value == "" ? null : widget.controller.ufSelected.value,
                                hintText: "Uf",
                                height: PlatformType.isTablet(context) ? 5.6.h : 6.5.h,
                                width: 23.w,
                                rxListItems: widget.controller.ufsList,
                                onChanged: (selectedState) {
                                  widget.controller.ufSelected.value = selectedState ?? "";
                                },
                              ),
                            ),
                            Expanded(
                              child: TextFieldWidget(
                                controller: widget.controller.cityTextController,
                                hintText: "Cidade",
                                textCapitalization: TextCapitalization.words,
                                height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                keyboardType: TextInputType.name,
                                enableSuggestions: true,
                                textInputAction: TextInputAction.next,
                                hasError: widget.controller.cityInputHasError.value,
                                validator: (String? value) {
                                  String? validation = TextFieldValidators.standardValidation(value, "Informe a Cidade");
                                  if(validation != null && validation != ""){
                                    widget.controller.cityInputHasError.value = true;
                                  }
                                  else{
                                    widget.controller.cityInputHasError.value = false;
                                  }
                                  return validation;
                                },
                                onEditingComplete: (){
                                  widget.controller.streetFocusNode.requestFocus();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Obx(
                            () => TextFieldWidget(
                              focusNode: widget.controller.streetFocusNode,
                              controller: widget.controller.streetTextController,
                              hintText: "Logradouro",
                              textCapitalization: TextCapitalization.words,
                              height: PlatformType.isTablet(context) ? 7.h : 9.h,
                              keyboardType: TextInputType.streetAddress,
                              enableSuggestions: true,
                              textInputAction: TextInputAction.next,
                              hasError: widget.controller.streetInputHasError.value,
                              validator: (String? value) {
                                String? validation = TextFieldValidators.standardValidation(value, "Informe o Logradouro");
                                if(validation != null && validation != ""){
                                  widget.controller.streetInputHasError.value = true;
                                }
                                else{
                                  widget.controller.streetInputHasError.value = false;
                                }
                                return validation;
                              },
                              onEditingComplete: (){
                                widget.controller.houseNumberFocusNode.requestFocus();
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: TextFieldWidget(
                            focusNode: widget.controller.houseNumberFocusNode,
                            controller: widget.controller.houseNumberTextController,
                            hintText: "Nº",
                            textInputAction: TextInputAction.next,
                            height: PlatformType.isTablet(context) ? 7.h : 9.h,
                            width: 20.w,
                            keyboardType: TextInputType.number,
                            onEditingComplete: (){
                              widget.controller.neighborhoodFocusNode.requestFocus();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.h),
                    child: Obx(
                      () => TextFieldWidget(
                        focusNode: widget.controller.neighborhoodFocusNode,
                        controller: widget.controller.neighborhoodTextController,
                        hintText: "Bairro",
                        textCapitalization: TextCapitalization.words,
                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                        width: double.infinity,
                        keyboardType: TextInputType.name,
                        enableSuggestions: true,
                        textInputAction: TextInputAction.next,
                        hasError: widget.controller.neighborhoodInputHasError.value,
                        validator: (String? value) {
                          String? validation = TextFieldValidators.standardValidation(value, "Informe o Bairro");
                          if(validation != null && validation != ""){
                            widget.controller.neighborhoodInputHasError.value = true;
                          }
                          else{
                            widget.controller.neighborhoodInputHasError.value = false;
                          }
                          return validation;
                        },
                        onEditingComplete: (){
                          widget.controller.complementFocusNode.requestFocus();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.h),
                    child: TextFieldWidget(
                      focusNode: widget.controller.complementFocusNode,
                      controller: widget.controller.complementTextController,
                      hintText: "Complemento",
                      textCapitalization: TextCapitalization.sentences,
                      height: PlatformType.isTablet(context) ? 7.h : 9.h,
                      width: double.infinity,
                      keyboardType: TextInputType.text,
                      enableSuggestions: true,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Entrys da terceira stepper
          Visibility(
            visible: widget.indexView == 2,
            child: Form(
              key: widget.controller.formKeyContactInformation,
              child: Column(
                children: [
                  TextFieldWidget(
                    controller: widget.controller.phoneTextController,
                    hintText: "Telefone",
                    textInputAction: TextInputAction.next,
                    height: PlatformType.isTablet(context) ? 7.h : 9.h,
                    width: double.infinity,
                    keyboardType: TextInputType.phone,
                    maskTextInputFormatter: [MasksForTextFields.phoneNumberMask],
                    hasError: widget.controller.phoneInputHasError.value,
                    validator: (String? value) {
                      String? validation = TextFieldValidators.phoneValidation(value);
                      if(validation != null && validation != ""){
                        widget.controller.phoneInputHasError.value = true;
                      }
                      else{
                        widget.controller.phoneInputHasError.value = false;
                      }
                      return validation;
                    },
                    onEditingComplete: (){
                      widget.controller.cellPhoneFocusNode.requestFocus();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.h),
                    child: TextFieldWidget(
                      focusNode: widget.controller.cellPhoneFocusNode,
                      controller: widget.controller.cellPhoneTextController,
                      hintText: "Celular",
                      textInputAction: TextInputAction.next,
                      height: PlatformType.isTablet(context) ? 7.h : 9.h,
                      width: double.infinity,
                      keyboardType: TextInputType.phone,
                      maskTextInputFormatter: [widget.controller.maskCellPhoneFormatter],
                      onChanged: (cellPhoneTyped) => widget.controller.phoneTextFieldEdited(cellPhoneTyped),
                      hasError: widget.controller.cellPhoneInputHasError.value,
                      validator: (String? value) {
                        String? validation = TextFieldValidators.cellPhoneValidation(value);
                        if(validation != null && validation != ""){
                          widget.controller.cellPhoneInputHasError.value = true;
                        }
                        else{
                          widget.controller.cellPhoneInputHasError.value = false;
                        }
                        return validation;
                      },
                      onEditingComplete: (){
                        widget.controller.emailFocusNode.requestFocus();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.h),
                    child: Obx(
                      () => TextFieldWidget(
                        focusNode: widget.controller.emailFocusNode,
                        controller: widget.controller.emailTextController,
                        hintText: "E-mail",
                        textInputAction: TextInputAction.next,
                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                        width: double.infinity,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        hasError: widget.controller.emailInputHasError.value,
                        validator: (String? value) {
                          String? validation = TextFieldValidators.emailValidation(value);
                          if(validation != null && validation != ""){
                            widget.controller.emailInputHasError.value = true;
                          }
                          else{
                            widget.controller.emailInputHasError.value = false;
                          }
                          return validation;
                        },
                        onEditingComplete: (){
                          widget.controller.confirmEmailFocusNode.requestFocus();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.h),
                    child: Obx(
                      () => TextFieldWidget(
                        focusNode: widget.controller.confirmEmailFocusNode,
                        controller: widget.controller.confirmEmailTextController,
                        hintText: "Confirme o E-mail",
                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                        width: double.infinity,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        hasError: widget.controller.confirmEmailInputHasError.value,
                        validator: (String? value) {
                          String? validation = TextFieldValidators.emailConfirmationValidation(widget.controller.emailTextController.text, value);
                          if(validation != null && validation != ""){
                            widget.controller.confirmEmailInputHasError.value = true;
                          }
                          else{
                            widget.controller.confirmEmailInputHasError.value = false;
                          }
                          return validation;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Entrys da quarta stepper
          Visibility(
            visible: widget.indexView == 3,
            child: Form(
              key: widget.controller.formKeyPasswordInformation,
              child: Column(
                children: [
                  Obx(
                    () => TextFieldWidget(
                      controller: widget.controller.passwordTextController,
                      hintText: "Senha",
                      height: PlatformType.isTablet(context) ? 7.h : 9.h,
                      width: double.infinity,
                      textInputAction: TextInputAction.next,
                      hasError: widget.controller.passwordInputHasError.value,
                      validator: (String? value) {
                        String? validation = TextFieldValidators.passwordValidation(value);
                        if(validation != null && validation != ""){
                          widget.controller.passwordInputHasError.value = true;
                        }
                        else{
                          widget.controller.passwordInputHasError.value = false;
                        }
                        return validation;
                      },
                      onEditingComplete: (){
                        widget.controller.confirmPasswordFocusNode.requestFocus();
                      },
                      isPassword: widget.controller.passwordFieldEnabled.value,
                      iconTextField: GestureDetector(
                        onTap: () {
                          widget.controller.passwordFieldEnabled.value =
                          !widget.controller.passwordFieldEnabled.value;
                        },
                        child: Icon(
                          widget.controller.passwordFieldEnabled.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.blackColor,
                          size: 2.5.h,
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.5.h),
                    child: Obx(
                      () => TextFieldWidget(
                        focusNode: widget.controller.confirmPasswordFocusNode,
                        controller: widget.controller.confirmPasswordTextController,
                        hintText: "Confirme a Senha",
                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                        width: double.infinity,
                        hasError: widget.controller.confirmPasswordInputHasError.value,
                        validator: (String? value) {
                          String? validation = TextFieldValidators.confirmPasswordValidation(widget.controller.passwordTextController.text, value);
                          if(validation != null && validation != ""){
                            widget.controller.confirmPasswordInputHasError.value = true;
                          }
                          else{
                            widget.controller.confirmPasswordInputHasError.value = false;
                          }
                          return validation;
                        },
                        isPassword: widget.controller.confirmPasswordFieldEnabled.value,
                        iconTextField: GestureDetector(
                          onTap: () {
                            widget.controller.confirmPasswordFieldEnabled.value =
                            !widget.controller.confirmPasswordFieldEnabled.value;
                          },
                          child: Icon(
                            widget.controller.confirmPasswordFieldEnabled.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.blackColor,
                            size: 2.5.h,
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}