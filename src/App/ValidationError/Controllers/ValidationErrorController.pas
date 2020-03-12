(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit ValidationErrorController;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * controller that handle route :
     * /validationerror
     *
     * See Routes/ValidationError/routes.inc
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TValidationErrorController = class(TAbstractController)
    private
        fValidator : IRequestValidator;
    public
        constructor create(const reqValidator : IRequestValidator);
        destructor destroy(); override;

        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse; override;
    end;

implementation

uses

    SysUtils;

    constructor TValidationErrorController.create(const reqValidator : IRequestValidator);
    begin
        fValidator := reqValidator;
    end;

    destructor TValidationErrorController.destroy();
    begin
        fValidator := nil;
        inherited destroy();
    end;

    function TValidationErrorController.handleRequest(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader
    ) : IResponse;
    var
        validationError : string;
        i : integer;
        validationRes : TValidationResult;
    begin
        validationRes := fValidator.lastValidationResult();
        validationError := '<ul>';
        for i:=0 to length(validationRes.errorMessages) - 1 do
        begin
            validationError := validationError +
                format('<li>%s</li>', [validationRes.errorMessages[i].errorMessage]);
        end;
        validationError := validationError + '</ul>';

        response.body().write(
            '<html><head><title>Validation Error</title></head>' +
            '<body><h1>Validation Error</h1>' + validationError +
            '</body>'
        );
        response.headers().setHeader('Status', '500 Validation Error');
        result := response;
    end;

end.
