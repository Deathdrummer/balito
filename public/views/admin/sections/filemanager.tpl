<div class="section filemanager mb-15px" id="sectionFilemanager">
	<div class="section_title">
		<h2>Менеджер файлов</h2>
	</div>

	<div class="row no-gutters">
		<div class="col-auto">
			<div class="filemanager__block filemanager__dirs">
				<div class="filemanager__buttons mb-3">
					<button id="newFolder" title=""><i class="fa fa-plus"></i></button>
					<button disabled id="editFolder" title=""><i class="fa fa-pencil-square-o"></i></button>
					<button disabled id="removeFolder" title=""><i class="fa fa-trash"></i></button>
					<input type="hidden" id="currentDir" value="">
				</div>
				<div class="filemanager__content filemanager__content_dirs">
					<ul class="filemanager__dirstree noselect" id="filemanagerDirs"></ul>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="filemanager__block filemanager__files">
				<div class="filemanager__buttons mb-3">
					<form hidden id="fileUploadForm" enctype="multipart/form-data" autocomplete="off">
						<input type="hidden" name="filemanager_path" id="filemanagerFormPath" value="">
						<input type="hidden" id="sizeBigWidth" name="size[big][width]" value="">
						<input type="hidden" id="sizeBigHeight" name="size[big][height]" value="">
						<input type="hidden" id="sizeSmallWidth" name="size[small][width]" value="">
						<input type="hidden" id="sizeSmallHeight" name="size[small][height]" value="">
						<input type="hidden" id="resizeVariant" name="size_variant" value="">
						<input type="file" name="filemanager_files[]" multiple>
					</form>
					<button id="fileUploadFormButton" disabled title=""><i class="fa fa-plus"></i></button>
					<button id="setWidthHeight" disabled title=""><i class="fa fa-crop"></i></button>
					<button id="replaceFiles" disabled title=""><i class="fa fa-retweet"></i></button>
					<button id="removeFiles" disabled title=""><i class="fa fa-trash"></i></button>
					<p style="font-size: 14px; margin-left: 10px; display: inline-block;" id="setWidthHeightInfo"></p>
				</div>
				<div class="filemanager__content filemanager__content_files noselect" id="filemanagerContentFiles"><p class="empty center">Выберите раздел</p></div>
			</div>
		</div>
	</div>	
</div>


		


<script type="text/javascript"><!--
$(document).ready(function() {
	function renderDirs(callback, newPath) {
		var currentDir = $('#currentDir').val();
		getAjaxHtml('filemanager/dirs_get', {current_dir: currentDir}, function(html) {
			$('#filemanagerDirs').html(html);
			if (newPath) $('#filemanagerDirs').find('[directory="'+newPath+'"]').addClass('active');
			if (callback && typeof callback == 'function') callback();
		});
	}
	
	renderDirs();
	
	
	// Задать размеры из кэша
	let cacheBigWidth = lscache.get('bigWidth'),
		cacheBigHeight = lscache.get('bigHeight'),
		cacheSmallWidth = lscache.get('smallWidth'),
		cacheSmallHeight = lscache.get('smallHeight');
		cacheResizeVariant = lscache.get('resizeVariant');
	
	
	if (cacheBigWidth) $('#sizeBigWidth').val(cacheBigWidth);
	if (cacheBigHeight) $('#sizeBigHeight').val(cacheBigHeight);
	if (cacheSmallWidth) $('#sizeSmallWidth').val(cacheSmallWidth);
	if (cacheSmallHeight) $('#sizeSmallHeight').val(cacheSmallHeight);
	if (cacheResizeVariant) $('#resizeVariant').val(cacheResizeVariant);
	
	$('#setWidthHeightInfo').html('Большие: '+(cacheBigWidth ? cacheBigWidth+'px' : 'авто')+'/'+(cacheBigHeight ? cacheBigHeight+'px' : 'авто')+' | Маленькие: '+(cacheSmallWidth ? cacheSmallWidth+'px' : 'авто')+'/'+(cacheSmallHeight ? cacheSmallHeight+'px' : 'авто')+' | Уменьшение: '+((!cacheResizeVariant || cacheResizeVariant == 'hard') ? 'Жестко' : '<span style="word-spacing:normal;">Если больше размер</span>'));
	
	
	
	
	$('#filemanagerDirs').on(tapEvent, '[directory]:not(.disabled):not(.active)', function() {
		var thisDirectory = $(this).attr('directory'); 
		$('#filemanagerDirs').find('[directory]').removeClass('active');
		$(this).addClass('active');
		$('#removeFiles, #replaceFiles').prop('disabled', true);
		$('#editFolder, #removeFolder').prop('disabled', false);
		$('#currentDir').val(thisDirectory);
		
		$('#filemanagerFormPath').val(thisDirectory);
		getAjaxHtml('filemanager/files_get', {directory: thisDirectory}, function(html) {
			$('#filemanagerContentFiles').html(html);
			$('#fileUploadFormButton, #setWidthHeight').prop('disabled', false);
		});
	});
	
	
	
	
	
	$('#newFolder').on(tapEvent, function() {
		let activeDir = $('#filemanagerDirs').find('[directory].active').attr('directory') || false;
		
		ddrPopUp({
			title: 'Новая директория|4',
			width: 500,
			buttons: [{id: 'addFolder', title: 'Добавить'}],
			close: 'Отмена',
		}, function(newFolderWin) {
			newFolderWin.wait();
			getAjaxHtml('filemanager/dirs_new', {active_dir: activeDir}, function(html) {
				newFolderWin.setData(html, false);
				$('#addFolder').on(tapEvent, function() {
					newFolderWin.wait();
					$('#newFolderForm').formSubmit({
						url: 'filemanager/dirs_add',
						success: function(response) {
							if (response == 5) {
								notify('Ошибка! Недопустимое название!', 'error');
								newFolderWin.wait(false);
							} else if (response == 4) {
								notify('Ошибка! Пустое название!', 'error');
								newFolderWin.wait(false);
							} else if (response == 3) {
								notify('Ошибка! Название содержит недопустимые символы!', 'error');
								newFolderWin.wait(false);
							} else if (response == 2) {
								notify('Такая директория уже существует!', 'info');
								newFolderWin.wait(false);
							} else if (response == 1) {
								notify('Директория успешно создана!');
								renderDirs(function() {
									newFolderWin.close();
								});
							} else {
								notify('Ошибка создания директории!', 'error');
							}
						},
						error: function() {
							newFolderWin.wait(false);
						}
					});
				});
			}, function() {
				newFolderWin.wait(false);
			});
		});
	});
	
	
	
	
	
	$('#editFolder').on(tapEvent, function() {
		var currentFolder = $('#filemanagerDirs').find('[directory].active');
		if (currentFolder.length == 0) {
			notify('Не выбрано ни одной директории!', 'error');
			return false;
		} else {
			var dirPath = $(currentFolder).attr('directory'),
				dirName = $(currentFolder).text();
		}
		
		ddrPopUp({
			title: 'Редиктирование директории|4',
			width: 500,
			buttons: [{id: 'updateDir', title: 'Применить'}],
			close: 'Отмена'
		}, function(updateFolderWin) {
			updateFolderWin.wait();
			getAjaxHtml('filemanager/dirs_edit', {
				name: dirName,
				path: dirPath
			}, function(html) {
				updateFolderWin.setData(html, false);
				$('#updateDir').on(tapEvent, function() {
					$('#editFolderForm').formSubmit({
						url: 'filemanager/dirs_update',
						success: function(newName) {
							if (newName == 3) {
								notify('Ошибка! Название содержит недопустимые символы!', 'error');
							}else if (newName) {
								notify('Директория успешно переименована!');
								
								dirPath = dirPath.split('/');
								dirPath[dirPath.length - 1] = newName;
								dirPath = dirPath.join('/');
								
								$('#filemanagerFormPath').val(dirPath);
								
								renderDirs(function() {
									updateFolderWin.close();
								}, dirPath);
							} else {
								notify('Ошибка переименования директории!', 'error');
							}
						}
					});
				});
			}, function() {
				updateFolderWin.wait(false);
			});
		});
	});
	
	
	
	
	
	
	
	
	$('#removeFolder').on(tapEvent, function() {
		var currentFolder = $('#filemanagerDirs').find('[directory].active');
		if (currentFolder.length == 0) {
			notify('Не выбрано ни одной директории!', 'error');
			return false;
		} else {
			var dirPath = $(currentFolder).attr('directory');
		}
		
		ddrPopUp({
			title: 'Удаление директории|4',
			width: 500,
			html: '<p class="center">Вы действительно хотите удалить директорию?</p> <p class="center">Внимание! Это повлечет за собой удаление всех файлов, находящихся внутри категории!</p>',
			buttons: [{id: 'removeDir', title: 'Удалить'}],
			close: 'Отмена'
		}, function(removeDirWin) {
			$('#removeDir').on(tapEvent, function() {
				removeDirWin.wait();
				$.post('/filemanager/dirs_remove', {path: dirPath}, function(response) {
					if (response) {
						notify('Директория успешно удалена!');
						renderDirs(function() {
							$('#editFolder, #removeFolder, #replaceFiles, #removeFiles').prop('disabled', true);
							removeDirWin.close();
							$('#fileUploadFormButton, #setWidthHeight').prop('disabled', true);
							$('#filemanagerContentFiles').html('<p class="empty center">Выберите раздел</p>');
						});
					} else {
						notify('Ошибка удаления директории!', 'error');
					}
				}, 'json').always(function() {
					removeDirWin.wait(false);
				}).fail(function(e) {
					notify('Системная ошибка!', 'error');
					showError(e);
				});
			});	
		});
	});
	
	
	
	
	

	
	
	//-------------------------------------------------------------------------
	
	
	
	
	
	
	var selectedFiles = [];
	$('#filemanagerContentFiles').selectable({
		classes: {
			"ui-selecting": "selected",
			"ui-selected": "selected"
		},
		distance: 0,
		filter: ".filmanager__file",
		stop: function(event, ui) {
			var sf = $('#filemanagerContentFiles').find('.filmanager__file.selected');
				selectedFiles = [];
			
			if (sf.length > 0) {
				$.each(sf, function(k, file) {
					var thisFileDir = $(file).attr('dirfile');
					selectedFiles.push(thisFileDir);
				});
				$('#removeFiles, #replaceFiles').removeAttrib('disabled');
			} else {
				$('#removeFiles, #replaceFiles').setAttrib('disabled');
			}
		}
	});
	
	
	
	// Удалить файл(ы)
	$('#removeFiles').on(tapEvent, function() {
		ddrPopUp({
			title: 'Удалить файлы|4',
			width: 500,
			html: '<p class="center">Вы действительно хотите удалить файлы?</p>',
			buttons: [{id: 'deleteFiles', title: 'Удалить'}],
			close: 'Отмена'
		}, function(deleteFilesWin) {
			$('#deleteFiles').on(tapEvent, function() {
				deleteFilesWin.wait();
				$.post('/filemanager/files_delete', {files: selectedFiles}, function(response) {
					if (response == 0) {
						notify('Ошибка! Файл недоступен для удаления!', 'error');
					} 
					else if (response == 1) {
						notify('Ошибка! Не удалось удалить файл!', 'error');
					}
					else if (response == 2) {
						$('#filemanagerContentFiles').find('.filmanager__file.ui-selected').remove();
						$('#removeFiles, #replaceFiles').prop('disabled', true);
						
						deleteFilesWin.close();
						if ($('#filemanagerContentFiles').find('.filmanager__file').length == 0) {
							$('#filemanagerContentFiles').html('<p class="empty center">Нет данных</p>');
						}
						notify('Файлы успешно удалены!');
					}
					else {
						notify('Неизвестная ошибка!', 'error');
					}
				}, 'json').always(function() {
					deleteFilesWin.wait(false);
				}).fail(function(e) {
					notify('Системная ошибка!', 'error');
					showError(e);
				});
			});
		});
	});
	
	
	
	
	
	
	$('#replaceFiles').on(tapEvent, function() {
		var currentFolder = $('#filemanagerDirs').find('[directory].active');
		if (currentFolder.length == 0) {
			notify('Не выбрано ни одной директории!', 'error');
			return false;
		} else {
			var dirPath = $(currentFolder).attr('directory');
		}
		
		ddrPopUp({
			title: 'Переместить файлы|4',
			width: 500,
			buttons: [{id: 'getReplaceFiles', title: 'Переместить'}],
			close: 'Отмена',
		}, function(replaceFilesWin) {
			replaceFilesWin.wait();
			getAjaxHtml('filemanager/files_replace', {currentdir: dirPath}, function(html) {
				replaceFilesWin.setData(html, false);
			}, function() {
				replaceFilesWin.wait(false);
			});
			
			$('#getReplaceFiles').on(tapEvent, function() {
				replaceFilesWin.wait();
				$('#filemanagerDirs').find('span').addClass('disabled');
				$('#removeFiles, #replaceFiles, #newFolder, #editFolder, #removeFolder, #fileUploadFormButton, #setWidthHeight').prop('disabled', true);
				$('#replaceFilesForm').formSubmit({
					url: 'filemanager/files_replace',
					fields: {
						replace: 1,
						files: JSON.stringify(selectedFiles)
					},
					success: function(response) {
						if (response) {
							var activeDirectory = $('#filemanagerDirs').find('[directory].active').attr('directory');
							getAjaxHtml('filemanager/files_get', {directory: activeDirectory}, function(html) {
								$('#filemanagerContentFiles').html(html);
								$('#newFolder, #editFolder, #removeFolder, #fileUploadFormButton, #setWidthHeight').prop('disabled', false);
								$('#filemanagerDirs').find('span').removeClass('disabled');
								replaceFilesWin.close();
							});
						} else {
							notify('Ошибка перемещения файлов', 'error');
						}
					},
					complete: function() {
						replaceFilesWin.wait(false);
					}
				});
			});
		});
	});
	
	
	
	
	
	
	
	
	
	
	// задать размеры
	$('#setWidthHeight').on(tapEvent, function() {
		let bigWidth = $('#sizeBigWidth').val() || 0,
			bigHeight = $('#sizeBigHeight').val() || 0,
			smallWidth = $('#sizeSmallWidth').val() || 0,
			smallHeight = $('#sizeSmallHeight').val() || 0,
			resizeVariant = $('#resizeVariant').val() || 0;
			
		ddrPopUp({
			title: 'Задать размеры изображений|5',
			width: 400,
			buttons: [{id: 'setWidthHeightButton', title: 'Задать'}, {id: 'unsetWidthHeightButton', title: 'Сбросить'}],
			closeByButton: false, // Закрывать окно только по кнопкам [ddrpopupclose]
			close: 'Отмена',
		}, function(setWidthHeightWin) {
			
			setWidthHeightWin.setData('filemanager/set_width_height', {big_width: bigWidth, big_height: bigHeight, small_width: smallWidth, small_height: smallHeight, resize_variant: resizeVariant}, function() {
				$('#setWidthHeightButton').on(tapEvent, function() {
					$('#sectionWait').addClass('visible filemanager');
					
					$('#hiddenSizeWidth').val($('#imageWidthField').val());
					$('#hiddenSizeHeight').val($('#imageHeightField').val());
					
					$('#sizeBigWidth').val($('#bigWidth').val());
					$('#sizeBigHeight').val($('#bigHeight').val());
					$('#sizeSmallWidth').val($('#smallWidth').val());
					$('#sizeSmallHeight').val($('#smallHeight').val());
					$('#resizeVariant').val($('[name="resize_variant"]:checked').val());
					
					var sBW = $('#bigWidth').val() != 0 ? $('#bigWidth').val() : false,
						sBH = $('#bigHeight').val() != 0 ? $('#bigHeight').val() : false,
						sSW = $('#smallWidth').val() != 0 ? $('#smallWidth').val() : false,
						sSH = $('#smallHeight').val() != 0 ? $('#smallHeight').val() : false,
						rV = $('#resizeVariant').val() ? $('#resizeVariant').val() : false,
						sText = 'Большие: '+(sBW ? sBW+'px' : 'авто')+'/'+(sBH ? sBH+'px' : 'авто')+' | Маленькие: '+(sSW ? sSW+'px' : 'авто')+'/'+(sSH ? sSH+'px' : 'авто')+' | Уменьшение: '+(rV == 'hard' ? 'Жестко' : '<span style="word-spacing:normal;">Если больше размер</span>');
						
					$('#setWidthHeightInfo').html(sText);
					notify('Размеры для изображений заданы!');
					
					
					lscache.set('bigWidth', $('#bigWidth').val());
					lscache.set('bigHeight', $('#bigHeight').val());
					lscache.set('smallWidth', $('#smallWidth').val());
					lscache.set('smallHeight', $('#smallHeight').val());
					lscache.set('resizeVariant', $('[name="resize_variant"]:checked').val());
					
					setWidthHeightWin.close();
					
					$('#fileUploadFormButton').trigger(tapEvent);
					setTimeout(function() {});
					$('#sectionWait').removeClass('visible filemanager');
				});
				
				$('#unsetWidthHeightButton').on(tapEvent, function() {
					$('#sizeBigWidth').val('');
					$('#sizeBigHeight').val('');
					$('#sizeSmallWidth').val('');
					$('#sizeSmallHeight').val('');
					
					lscache.remove('bigWidth');
					lscache.remove('bigHeight');
					lscache.remove('smallWidth');
					lscache.remove('smallHeight');
					
					notify('Размеры для изображений сброшены!');
					$('#setWidthHeightInfo').html('Большие: авто/авто | Маленькие: авто/авто');
					setWidthHeightWin.close();
				});
			});
		});	
	});
	
	
	
	
	
	
	
	
	$('#fileUploadFormButton').on(tapEvent, function() {
		$('#fileUploadForm').find('input[type="file"]').trigger('click');
	});
	
	
	$('#fileUploadForm').find('input[type="file"]').on('change', function() {
		$('#sectionWait').addClass('visible filemanager');
		$('#removeFiles, #replaceFiles, #newFolder, #editFolder, #removeFolder, #fileUploadFormButton, #setWidthHeight').prop('disabled', true);
		$('#filemanagerDirs').find('span').addClass('disabled');
		$('#fileUploadForm').formSubmit({
			url: 'filemanager/files_upload',
			success: function(response) {
				if (response == 2) {
					console.log('2');
				} else if (response == 1) {
					notify('Файлы успешно загружены!');
				} else if (typeof response == 'object') {
					var errorText = '<p>Ошибка! не удалось загрузить '+(response.length > 1 ? 'файлы:' : 'файл:')+'</p>';
					$.each(response, function(k, item) {
						errorText += '<p>- '+(item.file.name)+'</p>';
					});
					notify(errorText, 'error', 30);
				}
			},
			complete: function() {
				var activeDirectory = $('#filemanagerDirs').find('[directory].active').attr('directory');
				getAjaxHtml('filemanager/files_get', {directory: activeDirectory}, function(html) {
					$('#filemanagerContentFiles').html(html);
					$('#removeFiles, #replaceFiles, #newFolder, #editFolder, #removeFolder, #fileUploadFormButton, #setWidthHeight').prop('disabled', false);
					$('#filemanagerDirs').find('span').removeClass('disabled');
					$('#sectionWait').removeClass('visible filemanager');
					$("#fileUploadForm")[0].reset();
				});
			}
		});
	});
});
//--></script>